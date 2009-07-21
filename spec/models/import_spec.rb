require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Import do

  before do
    stub.instance_of(ImportFile).execute
  end

  it "has associated files" do
    Import.make_unsaved.files.should == []
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

      @incomplete_file = mock_model(ImportFile)

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
        @import.execute
      end

      it "executes incomplete ImportFiles" do
        @incomplete_file.should have_received.execute
      end

      it "marks the import as complete" do
        @import.should be_complete
      end

    end

  end

end
