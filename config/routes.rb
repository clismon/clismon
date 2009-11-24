ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'pages', :action => 'portada'
  map.dinero '/dinero', :controller => 'pages', :action => 'dinero'
end
