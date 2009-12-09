class PagesController < ApplicationController
  layout 'clismon'

  after_filter :cache_page

  def portada
  end

  def dinero
    @group = 'dinero'
    @background_color = 'white'
    @background = Imagify.image('fondo-dinero.jpg')
    @images = Imagify.group('dinero')
    render :action => 'slideshow'
  end

  def elotromundo
    @group = 'elotromundo'
    @background_color = 'black'
    @background = Imagify.image('neuronas1-1200.jpg')
    @images = Imagify.group('elotromundo')
    render :action => 'slideshow'
  end

  def workinprogress
  end
end
