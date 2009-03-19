class PhotosController < ApplicationController

  make_resourceful do
    
    actions :index, :new, :create, :show, :update
  
    before :show do
      @prior_photos = current_object.prior.all(:limit => 5)
      @subsequent_photos = current_object.subsequent.all(:limit => 5)
    end

  end
  
  protected
  
  def current_objects
    Photo.by_id.paginate(:page => params[:page])
  end
  
end
