class ImportsController < ApplicationController

  make_resourceful do
    
    actions :index, :new, :create, :show
  
  end
  
  protected
  
  def current_objects
    Import.recent.all
  end

end