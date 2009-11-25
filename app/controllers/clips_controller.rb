class ClipsController < ApplicationController
  layout 'posts'
  inherit_resources
  actions :index, :create, :destroy

  def index
    @clip = Clip.new
    index!
  end
end
