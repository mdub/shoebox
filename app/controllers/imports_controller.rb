class ImportsController < ApplicationController

  make_resourceful do
    
    actions :index, :show, :destroy
  
  end

  def create
    directory = params[:import][:directory] rescue nil
    if directory
      Import.of_dir(directory).execute_in_background
    end
    redirect_to imports_path
  end
  
  protected
  
  def current_objects
    Import.recent.all
  end

end