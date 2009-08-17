class ImportsController < ApplicationController

  make_resourceful do
    
    actions :index, :show, :destroy
  
  end

  def create
    directory = params[:import][:directory] rescue nil
    Import.of_dir(directory) if directory
    redirect_to(:action => :index)
  end
  
  protected
  
  def current_objects
    Import.recent.all
  end

end