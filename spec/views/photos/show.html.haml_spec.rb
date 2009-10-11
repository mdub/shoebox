require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/show" do

  before do
    @photo = stub_model(Photo, :id => 25)
    assigns[:photo] = @photo
    assigns[:prior_photos] = [stub_model(Photo, :id => 23)]
    assigns[:subsequent_photos] = [stub_model(Photo, :id => 32) ]
    stub(template).photo_image_path do |photo, variant|
      "/photos/#{photo.id}/#{variant}.jpg"
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
