require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/show" do

  before do
    @photo = stub_model(Photo, :id => 25)
    stub(@photo).previous { stub_model(Photo, :id => 23) }
    stub(@photo).next { stub_model(Photo, :id => 32) }
    assigns[:photo] = @photo
    stub(template).photo_snap_path do |photo|
      "/photos/#{photo.id}/snap.jpg"
    end
    stub(template).photo_thumb_path do |photo|
      "/photos/#{photo.id}/thumb.jpg"
    end
    render :action => "photos/show"
  end

  it "displays the photo snapshot" do
    response.should have_tag("img[src=?]", "/photos/25/snap\.jpg")
  end

  it "links to the previous photo" do
    response.should have_tag("a[href=?]", "/photos/23") do
      with_tag("img.thumb[src=?]", "/photos/23/thumb\.jpg")
    end
  end

  it "links to the next photo" do
    response.should have_tag("a[href=?]", "/photos/32") do
      with_tag("img.thumb[src=?]", "/photos/32/thumb\.jpg")
    end
  end

end
