class PhotosController < ApplicationController

  make_resourceful do
    actions :index, :new, :create, :show
  end
  
  def current_objects
    Photo.paginate(:all, :page => params[:page])
  end
  
end
