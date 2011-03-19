require "pathname"

require 'spec_helper'

describe Photo do
  
  describe "- uploaded" do

    before do
      upload = File.new("#{fixture_path}/images/ngara-on-train.jpg")
      @photo = Photo.create!(:image => upload)
    end

    it "is stored in /public/system/photos" do
      image_path = Pathname(@photo.image.path)
      relative_path = image_path.relative_path_from(Rails.root + "public/system/photos")
      relative_path.to_s.should =~ %r{^\d{4}/\d{4}/ngara-on-train\.jpg$}
      image_path.should exist
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

  describe "#full_filename" do
    
    before(:all) do
      @photo = Photo.from_file(image_fixture_file("jonah-with-tractor.jpg"))
    end

    it "returns the absolute file path" do
      Pathname(@photo.full_filename).should be_absolute
    end
    
  end
  
  describe "#sha1_digest" do

    before do
      @photo = Photo.from_file(image_fixture_file("ngara-on-train.jpg"))
    end

    it "is derived from image" do
      @photo.sha1_digest.should =~ /^[0-9a-f]{40}$/
    end
    
    it "must be unique" do
      Photo.from_file(image_fixture_file("ngara-on-train.jpg")).save!
      @photo.save.should be_false
      @photo.errors_on(:sha1_digest).to_s.should =~ /duplicate/
    end
    
  end
  
  describe "#taken_at" do

    before do
      ENV['TZ'] = "UTC"
      @photo = Photo.from_file(image_fixture_file("ngara-on-train.jpg"))
    end

    it "is derived from image" do
      @photo.save.should be_true
      @photo.taken_at.should == Time.utc(2008, 1, 13, 15, 4, 42)
    end
    
  end
  
  describe "#write_variant" do
  
    it "invokes (ImageMagick) 'convert' with specified arguments" do
      @photo = Photo.new
      stub(@photo).full_filename { "/a/b/c.jpg" }
      stub(@photo).system { true }
      
      @photo.write_variant("-resize", "50x60", "result.jpg")
      
      @photo.should have_received.system("convert", "/a/b/c.jpg", "-resize", "50x60", "result.jpg")
    end
  
    it "throws an exception if convert fails" do
      @photo = Photo.new
      stub(@photo).full_filename { "/a/b/c.jpg" }
      stub(@photo).system { false }

      lambda do
        @photo.write_variant("-resize", "50x60", "result.jpg")
      end.should raise_error
      
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
      @photo1 = load_image "safari.png", :taken_at => 1.day.ago
      @photo2 = load_image "finder.png", :taken_at => 1.month.ago
      @photo3 = load_image "date.png", :taken_at => 3.minutes.ago
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
