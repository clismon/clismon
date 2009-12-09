ActionController::Routing::Routes.draw do |map|
  map.resources :clips

  map.resources :posts, :as => 'bueh', :collection => [:admin]

  map.root :controller => 'pages', :action => 'portada'
  map.dinero '/enlaces', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/doplacie', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/historietas', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/dinero', :controller => 'pages', :action => 'dinero'
  map.dinero '/elotromundo', :controller => 'pages', :action => 'elotromundo'
  map.dinero '/enciclopedia', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/tierra', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/encargos', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/mucirecor', :controller => 'pages', :action => 'workinprogress'
  map.dinero '/enlaces', :controller => 'pages', :action => 'workinprogress'
end
