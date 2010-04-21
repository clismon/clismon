class BuahController < ApplicationController
  layout 'posts'
  
  def index
    @posts = Post.all(:order => 'id DESC')
  end
end
