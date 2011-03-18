require 'spec_helper'

describe Importer do

  before do
    @importer = Importer.new
    @output = ""
    @importer.out = StringIO.new(@output)
  end
  
  describe "#import" do
    
    before do
      stub(File).exists?(anything) { true }
    end
    
    it "imports named files" do
      stub(Photo).from_file { stub_model(Photo, :save => true) }
      @importer.import(%w(a.jpg b.jpg))
      @output.should =~ /imported.* a\.jpg/
      @output.should =~ /imported.* b\.jpg/
    end
    
    it "reports errors on import failure" do
      @photo = stub_model(Photo, :save => false)
      stub(@photo).errors.stub!.full_messages { ["shit happened"] }
      stub(Photo).from_file { @photo }
      @importer.import(%w(a.jpg))
      @output.should =~ /  - shit happened/
    end
    
  end
  
  describe "with an archive directory" do
    
    before do
      @original_photo_file = Pathname("#{test_tmp_dir}/photo.jpg")
      FileUtils.copy(image_fixture_file("jonah-with-tractor.jpg"), @original_photo_file)
      @original_photo_file.should exist
      
      @archive_dir = Pathname("#{test_tmp_dir}/archive")
      @archive_dir.mkpath
      @importer.archive_dir = @archive_dir
      @archived_photo_file = @archive_dir + "photo.jpg"
    end

    after do
      FileUtils.rm_f(@original_photo_file)
      @archive_dir.rmtree
    end
    
    it "moves imported photos into the archive" do
      @importer.import([@original_photo_file])
      @original_photo_file.should_not exist
      @archived_photo_file.should exist
    end

    it "does not move photos that fail to import" do
      mock.instance_of(Photo).save { false }
      @importer.import([@original_photo_file])
      @original_photo_file.should exist
      @archived_photo_file.should_not exist
    end
    
  end
  
end
