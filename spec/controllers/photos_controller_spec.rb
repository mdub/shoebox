require File.dirname(__FILE__) + '/../spec_helper'

describe PhotosController do
  
  describe "#current_objects" do
    
    it "returns a paginated list of photos" do
      @paginated_photos = ["paginated list of photos"].paginate
      stub(controller).params do 
        { :page => 3 }
      end
      mock(Photo).paginate(:all, :page => 3) do
        @paginated_photos
      end
      controller.current_objects.should == @paginated_photos
    end
    
  end
  
end
