class PhotosController < ApplicationController

  def index
    @photos = Photo.find(:all)
  end

  def new
    @photo = Photo.new
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = 'Photo saved.'
      redirect_to photos_path
    else
      render :action => :new
    end
  end

end
