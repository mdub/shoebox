require 'spec_helper'

describe VariantsController do

  before do 
    @photo = stub_model(Photo, :id => 123)
    stub(Photo).find_by_id { @photo }
    stub(@photo).write_variant
    stub(controller).send_file do |file, options|
      controller.render :text => "rendering #{file}"
    end
  end

  describe "#show" do

    it "serves a transformed image" do

      stub(VariantsController::VARIANTS).[]("xyz") { ["-futz", "withit"] }  

      get :show, :photo_id => "123", :id => "123-xyz", :format => "jpg"

      response.code.should == "200"
      
      @photo.should have_received.write_variant("-futz", "withit", anything)

      controller.should have_received.send_file(anything, :disposition => "inline", :type => "image/jpeg", :stream => true)

    end

  end

end
