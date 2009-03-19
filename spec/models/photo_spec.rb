require "pathname"

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  
  describe "- uploaded" do

    before do
      upload = ActionController::TestUploadedFile.new("#{fixture_path}/images/ngara-on-train.jpg", "image/jpeg")
      @photo = Photo.create!(:uploaded_data => upload)
    end

    it "is stored in /public/var/test/photos" do
      @photo.public_filename.should =~ %r{^/var/#{Rails.env}/photos/.*/ngara-on-train\.jpg$}
      image_file_path = "#{RAILS_ROOT}/public#{@photo.public_filename}"
      Pathname(image_file_path).should exist
    end
    
  end

  describe ".from_file" do
    
    before(:all) do
      @photo = Photo.from_file(image_fixture_file("jonah-with-tractor.jpg"))
    end

    it "derives the content_type" do
      @photo.content_type.should == "image/jpeg"
    end

    it "derives the filename" do
      @photo.filename.should == "jonah-with-tractor.jpg"
    end
    
    it "is in a savable state" do
      @photo.save
      @photo.errors.should be_empty
    end
    
  end

  describe "#sha1_digest" do

    before do
      @photo = Photo.from_file(image_fixture_file("ngara-on-train.jpg"))
    end

    it "starts empty" do
      @photo.sha1_digest.should == nil
    end
    
    it "is derived on save" do
      @photo.save.should be_true
      @photo.sha1_digest.should =~ /^[0-9a-f]{40}$/
    end
    
    it "must be unique" do
      Photo.from_file(image_fixture_file("ngara-on-train.jpg")).save!
      @photo.save.should be_false
      @photo.errors_on(:sha1_digest).to_s.should =~ /duplicate/
    end
    
  end
  
  describe "#timestamp" do

    before do
      ENV['TZ'] = "UTC"
      @photo = Photo.from_file(image_fixture_file("ngara-on-train.jpg"))
    end

    it "starts empty" do
      @photo.timestamp.should == nil
    end
    
    it "is derived on save" do
      @photo.save.should be_true
      @photo.timestamp.should == Time.utc(2008, 1, 13, 15, 4, 42)
    end
    
  end
  
  describe "collection" do

    def load_image(name, options = {})
      photo = Photo.from_file(image_fixture_file(name))
      photo.attributes = options
      photo.save!
      photo
    end
    
    before do
      @photo1 = load_image "safari.png", :timestamp => 1.day.ago
      @photo2 = load_image "finder.png", :timestamp => 1.month.ago
      @photo3 = load_image "date.png", :timestamp => 3.minutes.ago
    end

    describe "member" do

      describe "#previous" do

        it "returns the previous photo" do
          @photo2.previous.should == @photo1
        end

        it "returns nil if there's no previous photo" do
          @photo1.previous.should == nil
        end
        
      end

      describe "#next" do

        it "returns the next photo" do
          @photo2.next.should == @photo3
        end

        it "returns nil if there's no next photo" do
          @photo3.next.should == nil
        end

      end

    end

  end

end
