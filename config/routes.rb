ActionController::Routing::Routes.draw do |map|
  
  map.resources :photos do |photo|
    photo.resources :variants
  end

  map.resources :imports, :member => { :start => :post }
  
  map.root :controller => "welcome"

end
