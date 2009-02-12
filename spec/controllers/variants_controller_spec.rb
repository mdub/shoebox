require File.dirname(__FILE__) + '/../spec_helper'

describe VariantsController do

  describe "#show" do
    
    before do 
      @photo = "mock photo"
      stub(Photo).find("123") { @photo }
    end
    
    it "serves a scaled down image" do
      
      request_path = "/photos/123/snap.jpg"
      stub(request).path { request_path }
      
      expected_filename = File.join(Rails.public_path, request_path)

      image = "image"
      mock(@photo).with_image { |block| block.call(image) }

      thumb = "thumbnail"
      mock(image).thumbnail(800) { |size, block| block.call(thumb) }
      
      mock(thumb).save(expected_filename)

      mock(controller).send_file(expected_filename, :disposition => "inline", :type => "image/jpeg")
      
      get :show, :photo_id => "123", :id => "800", :format => "jpg"
      
      response.content_type.should == "image/jpeg"
      
    end
    
  end
  
end
