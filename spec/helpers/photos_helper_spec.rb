require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosHelper do

  before do
    @photo = "some photo"
  end
  
  describe "#photo_snap_path" do
    
    it "scales down to fit 800x800" do
      mock(helper).formatted_photo_variant_path(@photo, "800", "jpg")
      helper.photo_snap_path(@photo)
    end
    
  end
  
  describe "#photo_thumb_path" do
    
    it "scales down to fit 150x150" do
      mock(helper).formatted_photo_variant_path(@photo, "150", "jpg")
      helper.photo_thumb_path(@photo)
    end
    
  end
  
end
