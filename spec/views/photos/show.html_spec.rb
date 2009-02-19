require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/show" do

  before do
    @photo = mock_model(Photo, :id => 25, :prev_id => 23, :next_id => 32)
    assigns[:photo] = @photo
    stub(template).photo_snap_path do |photo|
      "/photos/#{photo.id}/snap.jpg"
    end
    stub(template).photo_thumb_path do |photo_id|
      "/photos/#{photo_id}/thumb.jpg"
    end
    render :action => "photos/show"
  end

  it "displays the photo snapshot" do
    response.should have_tag("img[src=?]", "/photos/25/snap\.jpg")
  end

  it "links to the previous photo" do
    response.should have_tag("a[href=?]", "/photos/23") do
      with_tag("img[src=?]", "/photos/23/thumb\.jpg")
    end
  end

end
