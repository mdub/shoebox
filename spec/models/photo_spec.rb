require "pathname"

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  
  describe "- uploaded" do

    before do
      @photo = Photo.create!(:uploaded_data => fixture_file_upload("images/ngara-on-train.jpg", "image/jpeg"))
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
      @photo.errors_on(:sha1_digest).should include("duplicates an existing photo")
    end
    
  end
  
  describe "collection" do

    before do
      Photo.from_file(image_fixture_file("finder.png")).save!
      Photo.from_file(image_fixture_file("safari.png")).save!
      Photo.from_file(image_fixture_file("date.png")).save!
      @photos = Photo.all
    end

    describe "member" do

      describe "#prev_id" do

        it "returns the id of the previous photo" do
          @photos[1].prev_id.should == @photos[0].id
        end

      end

      describe "#next_id" do

        it "returns the id of the next photo" do
          @photos[1].next_id.should == @photos[2].id
        end

      end

    end

  end

end
