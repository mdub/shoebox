require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosHelper do

  before do
    @photo = "some photo"
  end
  
  describe "#photo_snap_path" do
    
    it "scales down to fit 600x600" do
      mock(helper).formatted_photo_variant_path(@photo, "600", "jpg")
      helper.photo_snap_path(@photo)
    end
    
  end
  
  describe "#photo_thumb_path" do
    
    it "crops and scales to fit 100x100" do
      mock(helper).formatted_photo_variant_path(@photo, "100c", "jpg")
      helper.photo_thumb_path(@photo)
    end
    
  end
  
end
