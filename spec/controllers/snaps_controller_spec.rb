require File.dirname(__FILE__) + '/../spec_helper'

describe SnapsController do

  describe "#show" do
    
    before do 
      @photo = "mock photo"
      stub(Photo).find("123") { @photo }
    end
    
    it "serves a scaled down image" do
      
      request_path = "/photos/123/snap.jpg"
      stub(request).path { request_path }
      
      expected_filename = File.join(Rails.public_path, request_path)
      mock(@photo).create_thumbnail(expected_filename, 800)
      mock(controller).send_file(expected_filename, :disposition => "inline", :type => "image/jpeg")
      
      get :show, :photo_id => "123", :format => "jpg"
      
      response.content_type.should == "image/jpeg"
      
    end
    
  end
  
end
