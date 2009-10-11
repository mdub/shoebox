require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosHelper do

  before do
    @photo = "some photo"
  end
  
  describe "#photo_image_path" do
    
    it "points to a snap" do
      mock(helper).photo_variant_path(@photo, :snap, :format => "jpg")
      helper.photo_image_path(@photo)
    end
    
  end
  
end
