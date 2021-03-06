require 'spec_helper'

require "fileutils"
require "pathname"

class Pathname
  
  def touch
    FileUtils.touch(self.to_s)
  end
  
end

describe Import do

  before do
    stub.instance_of(ImportFile).execute
  end

  it "has associated files" do
    Import.make_unsaved.files.should == []
  end 

  describe ".of_dir" do
    
    it "attaches a ImportFile for all images in the directory" do
      @photo_dir = Pathname(test_tmp_dir) + "mypix"
      @photo_dir.mkpath
      (@photo_dir + "aaa.jpg").touch
      (@photo_dir + "bbb.jpg").touch
      @import = Import.of_dir(@photo_dir.to_s)
      @import.files.should have(2).entries
    end
    
  end
  
  describe "when complete" do
    
    before do
      @original_completion_time = 1.hour.ago.change(:usec => 0)
      @import = Import.make(:completed_at => @original_completion_time)
    end

    describe "#execute" do
      
      it "does nothing" do
        @import.completed_at.should == @original_completion_time
      end
      
    end
    
  end

  describe "when not complete" do

    before do

      @import = Import.make

      @incomplete_file = stub_model(ImportFile)

      stub(@import).files.stub!.incomplete {
        [
          @incomplete_file
        ]
      }

    end

    describe "#complete?" do
      
      it "returns false" do
        @import.should_not be_complete
      end
      
    end
    
    describe "#execute" do

      before do
        @completed = []
        @import.execute do |x|
          @completed << x
        end
        stub(@incomplete_file).execute
      end

      it "executes incomplete ImportFiles" do
        @incomplete_file.should have_received.execute
      end

      it "marks the import as complete" do
        @import.should be_complete
      end

      it "calls the associated block for each completed file" do
        @completed.should == [@incomplete_file]
      end
      
    end

    describe "#execute_in_background" do
      
      it "queues a BJ job" do

        @import = Import.make
        expected_background_command = "./jobs/execute_import #{@import.id}"
        stub(Bj).submit(anything)
        
        @import.execute_in_background
        
        Bj.should have_received.submit(expected_background_command)
        
      end
      
    end
    
  end

end
