class PhotosController < ApplicationController

  make_resourceful do
    actions :index, :new, :create, :show, :update
  end
  
  protected
  
  def current_objects
    Photo.by_timestamp.paginate(:page => params[:page])
  end
  
end
