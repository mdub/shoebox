require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosHelper do

  before do
    @photo = "some photo"
  end
  
  describe "#photo_snap_path" do
    
    it "points to a snap" do
      mock(helper).photo_variant_path(@photo, "snap", :format => "jpg")
      helper.photo_snap_path(@photo)
    end
    
  end
  
  describe "#photo_thumb_path" do
    
    it "points to a thumbnail" do
      mock(helper).photo_variant_path(@photo, "thumb", :format => "jpg")
      helper.photo_thumb_path(@photo)
    end
    
  end
  
end
