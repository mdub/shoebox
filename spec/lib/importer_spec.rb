require File.dirname(__FILE__) + '/../spec_helper'

describe Importer do

  before do
    @importer = Importer.new
    @output = ""
    @importer.out = StringIO.new(@output)
  end
  
  describe "#import" do
    
    it "imports named files" do
      stub(Photo).from_file("a.jpg") { mock_model(Photo, :save => true) }
      stub(Photo).from_file("b.jpg") { mock_model(Photo, :save => true) }
      @importer.import(%w(a.jpg b.jpg))
      @output.should =~ /imported.* a\.jpg/
      @output.should =~ /imported.* b\.jpg/
    end
    
    it "reports errors on import failure" do
      @photo = mock_model(Photo, :save => false, :errors => ["shit happened"])
      stub(Photo).from_file("a.jpg") { @photo }
      @importer.import(%w(a.jpg))
      @output.should =~ /  - shit happened/
    end
    
  end
  
end
