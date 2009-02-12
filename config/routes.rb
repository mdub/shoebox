ActionController::Routing::Routes.draw do |map|
  
  map.resources :photos do |photo|
    photo.resources :variants
  end

  map.root :controller => "welcome"

end
