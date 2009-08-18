require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ImportFile do

  before do
    @import_file = ImportFile.make_unsaved
  end

  it "must be associated with an Import" do
    @import_file.import = nil
    @import_file.should_not be_valid
  end

  it "must have a path" do
    @import_file.path = nil
    @import_file.should_not be_valid
  end

  it "starts incomplete" do
    @import_file.completed_at.should be_nil
    @import_file.complete?.should == false
  end
  
  describe "#execute" do

    before do
      @photo = stub_model(Photo, :path => "/path/to/file.jpg")
      stub(Photo).from_file(anything) { @photo }
      stub(@photo).save { true }
    end

    it "tries to create a Photo from the named file" do
      @import_file.execute
      Photo.should have_received.from_file(@import_file.path)
    end

    describe "- if Photo is valid" do

      before do
        stub(@photo).save { true }
        @import_file.execute
      end

      it "populates completed_at" do
        @import_file.completed_at.should_not be_nil
      end
      
      it "populates photo_id" do
        @import_file.photo.should == @photo
      end
      
    end

    describe "- if Photo cannot be saved" do
      
      before do
        stub(@photo).save { false }
        stub(@photo).errors.stub!.full_messages { ["error1", "error2"] }
        @import_file.execute
      end
      
      it "populates completed_at" do
        @import_file.completed_at.should_not be_nil
      end
      
      it "records errors" do
        @import_file.message.should == ["error1", "error2"].to_yaml
      end
      
      it "is considered failed" do
        @import_file.should be_failed
      end

    end
    
  end
  
end
