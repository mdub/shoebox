require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/show" do

  before do
    @photo = stub_model(Photo, :id => 25)
    @prior_photos = [stub_model(Photo, :id => 23)]
    @subsequent_photos = [stub_model(Photo, :id => 32)]
    stub(view).photo_image_path do |photo, variant|
      "/photos/#{photo.id}/#{variant}.jpg"
    end
    render
  end

  it "displays the photo snapshot" do
    rendered.should have_tag("img", :with => {:src => "/photos/25/snap\.jpg"})
  end

  it "links to the previous photo" do
    rendered.should have_tag("a", :with => {:href => "/photos/23"}) do
      with_tag("img.thumb", :with => {:src => "/photos/23/thumb\.jpg"})
    end
  end

  it "links to the next photo" do
    rendered.should have_tag("a", :with => {:href => "/photos/32"}) do
      with_tag("img.thumb", :with => {:src => "/photos/32/thumb\.jpg"})
    end
  end

end
