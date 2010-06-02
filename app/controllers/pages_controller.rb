class PagesController < ApplicationController
  layout 'clismon'

  after_filter :cache_page

  def section
    @group = Group.find_by_name(params[:id])
  end

  def portada
  end

  def workinprogress
  end
end
