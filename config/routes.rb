ActionController::Routing::Routes.draw do |map|
  
  map.resources :photos do |photo|
    photo.resource :snap
  end

  map.root :controller => "welcome"

end
