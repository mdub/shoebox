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

    it "displays photo thumbails" do
      response.should have_tag("ul.photos") do
        @photos.each do |photo|
          with_tag("li#photo_#{photo.id} img.thumb") 
        end
      end
    end

    it "includes links to each photo" do
      response.should have_tag("ul.photos") do
        @photos.each do |photo|
          with_tag("li#photo_#{photo.id} a[href=?]", "/photos/#{photo.id}")
        end
      end
    end

  end

end
