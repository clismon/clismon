ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pages', :action => 'portada'

  map.resources :groups, :as => 'admin' do |group|
    group.resources :clips, :controller => 'clips', :as => 'clips'
  end

  map.enlaces '/lecrou', :controller => 'pages', :action => 'section', :id => 'lecrou'
  map.doplacie '/doplacie', :controller => 'pages', :action => 'section', :id => 'doplacie'
  map.historietas '/historietas', :controller => 'pages', :action => 'section', :id => 'historietas'
  map.dinero '/dinero', :controller => 'pages', :action => 'section', :id => 'dinero'
  map.elotromundo '/elotromundo', :controller => 'pages', :action => 'section', :id=> 'elotromundo'
  map.elotromundo '/enciclopedia', :controller => 'pages', :action => 'section', :id=> 'enciclopedia'
  map.elotromundo '/tierra', :controller => 'pages', :action => 'section', :id=> 'tierra'
  map.elotromundo '/encargos', :controller => 'pages', :action => 'section', :id=> 'encargos'
  map.elotromundo '/muvirecor', :controller => 'pages', :action => 'section', :id=> 'muvirecor'
  
  Jammit::Routes.draw(map)
  # map.connect ':controller/:action/:id'
end
