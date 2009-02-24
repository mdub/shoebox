require File.dirname(__FILE__) + '/../spec_helper'

describe VariantsController do

  before do 
    @photo = "mock photo"
    stub(Photo).find_by_id("123") { @photo }
    @image = "image"
    mock(@photo).with_image { |block| block.call(@image) }
  end

  describe "#show" do

    describe "'800'" do

      it "serves a scaled down image" do

        thumb = "thumbnail"
        mock(@image).thumbnail(800) { |size, block| block.call(thumb) }
        mock(thumb).save(anything)
        mock(controller).send_file(anything, :disposition => "inline", :type => "image/jpeg")

        get :show, :photo_id => "123", :id => "800", :format => "jpg"
        response.content_type.should == "image/jpeg"

      end

    end

    describe "'150c'" do

      it "serves a cropped thumbnail" do

        thumb = "thumbnail"
        mock(@image).cropped_thumbnail(150) { |size, block| block.call(thumb) }
        mock(thumb).save(anything)
        mock(controller).send_file(anything, :disposition => "inline", :type => "image/jpeg")

        get :show, :photo_id => "123", :id => "150c", :format => "jpg"
        response.content_type.should == "image/jpeg"

      end

    end

  end

end
