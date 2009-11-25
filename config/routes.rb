ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :as => 'blog', :collection => [:admin]

  map.root :controller => 'pages', :action => 'portada'
  map.dinero '/dinero', :controller => 'pages', :action => 'dinero'
  map.dinero '/elotromundo', :controller => 'pages', :action => 'elotromundo'
end
