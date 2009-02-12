require File.dirname(__FILE__) + '/../spec_helper'

describe SnapsController do

  describe "#show" do
    
    before do 
      @photo = "mock photo"
      stub(Photo).find("123") { @photo }
    end
    
    it "serves a scaled down image" do
      
      mock(@photo).create_thumbnail(anything, 800)
      mock(controller).send_file(anything, :disposition => "inline", :type => "image/jpeg")
      
      get :show, :photo_id => "123", :format => "jpg"
      
      response.content_type.should == "image/jpeg"
      
    end
    
  end
  
end
