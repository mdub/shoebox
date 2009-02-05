class PhotosController < ApplicationController
  
  def index
    @photos = Photo.find(:all)
  end
  
end
