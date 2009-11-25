class ClipsController < ApplicationController
  layout 'posts'
  inherit_resources
  actions :index, :create, :destroy

  def index
    @clip = Clip.new
    index!
  end

  def create
    create! do |success, failure|
      success.html {redirect_to clips_path}
      failure.html { render :action => 'index'}
    end
  end
end
