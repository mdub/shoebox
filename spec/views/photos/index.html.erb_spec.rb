require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/index" do

  describe "with 3 photos" do

    before do
      assigns[:photos] = [
        mock_model(Photo, :public_filename => "/photos/a"),
        mock_model(Photo, :public_filename => "/photos/b"),
        mock_model(Photo, :public_filename => "/photos/c")
      ]
    end

    it "should include links to each photo" do
      render :action => "photos/index"
      %w(a b c).each do |photo_id|
        response.should have_tag("a", :href => "/photos/#{photo_id}")
      end
    end

  end

end
