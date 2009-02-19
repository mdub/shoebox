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

  describe "collection" do

    before do
      @photos = (1..3).map do 
        returning(photo = Photo.from_file(image_fixture_file("date.png"))) do
          photo.save!
          photo.reload
        end
      end
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
