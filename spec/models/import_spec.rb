require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Import do

  before(:each) do
    @import = Import.make_unsaved
  end

  it "has associated files" do
    @import.files.should == []
  end 

  describe "#execute" do
    
    before(:each) do
      
      stub.instance_of(ImportFile).execute
      
      @import = Import.make
      
      @incomplete_file = mock_model(ImportFile)

      stub(@import).files.stub!.incomplete {
        [
          @incomplete_file
        ]
      }
      
      
      @import.execute
      
    end
    
    it "executes incomplete ImportFiles" do
      @incomplete_file.should have_received.execute
    end
    
  end
  
end
