require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/index" do

  describe "with 3 photos" do

    before do
      @photos = (1..3).map do
        stub_model(Photo)
      end.paginate(:page => 1)
      render
    end

    it "displays photo thumbails" do
      rendered.should have_tag("ul.photos") do
        @photos.each do |photo|
          with_tag("li#photo_#{photo.id} img.thumb") 
        end
      end
    end

    it "includes links to each photo" do
      rendered.should have_tag("ul.photos") do
        @photos.each do |photo|
          with_tag("li#photo_#{photo.id} a", :with => {:href => "/photos/#{photo.id}"})
        end
      end
    end

  end

end
