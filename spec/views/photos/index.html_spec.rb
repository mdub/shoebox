require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/index" do

  describe "with 3 photos" do

    before do
      @photos = (1..3).map do
        mock_model(Photo)
      end.paginate(:page => 1)
      assigns[:photos] = @photos
      render :action => "photos/index"
    end

    it "should include links to each photo" do
      @photos.each do |photo|
        response.should have_tag("a[href=?]", "/photos/#{photo.id}")
      end
    end

  end

end
