require 'spec_helper'

describe PhotosHelper do

  before do
    @photo = "some photo"
    stub(@photo).id { 1234 }
  end
  
  describe "#photo_image_path" do
    
    it "points to a snap" do
      mock(helper).photo_variant_path(@photo, "1234-snap", :format => "jpg")
      helper.photo_image_path(@photo)
    end
    
  end
  
end
