require File.dirname(__FILE__) + '/../spec_helper'

describe VariantsController do

  before do 
    @photo = "mock photo"
    stub(Photo).find_by_id("123") { @photo }
    stub(@photo).write_variant
    stub(controller).send_file
  end

  describe "#show" do

    it "serves a transformed image" do

      stub(VariantsController::VARIANTS).[]("xyz") { ["-futz", "withit"] }  

      get :show, :photo_id => "123", :id => "xyz", :format => "jpg"

      @photo.should have_received.write_variant("-futz", "withit", anything)

      controller.should have_received.send_file(anything, :disposition => "inline", :type => "image/jpeg", :stream => true)
      response.content_type.should == "image/jpeg"

    end

  end

end
