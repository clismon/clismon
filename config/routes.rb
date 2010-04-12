ActionController::Routing::Routes.draw do |map|
  map.resources :clips

  map.resources :posts, :as => 'bueh', :collection => [:admin]

  map.resources :groups, :as => 'g' do |group|
    map.resources :clips, :controller => 'group_clips', :as => 'clips'
  end

  map.root :controller => 'pages', :action => 'portada'
  map.enlaces '/enlaces', :controller => 'pages', :action => 'workinprogress'
  map.doplacie '/doplacie', :controller => 'pages', :action => 'group', :id => 'doplacie'
  map.historietas '/historietas', :controller => 'pages', :action => 'group', :id => 'historietas'
  map.dinero '/dinero', :controller => 'pages', :action => 'group', :id => 'dinero'
  map.elotromundo '/elotromundo', :controller => 'pages', :action => 'group', :id=> 'elotromundo'
  map.enciclopedia '/enciclopedia', :controller => 'pages', :action => 'workinprogress'
  map.tierra '/tierra', :controller => 'pages', :action => 'workinprogress'
  map.encargos '/encargos', :controller => 'pages', :action => 'workinprogress'
  map.muvirecor '/muvirecor', :controller => 'pages', :action => 'workinprogress'
end
