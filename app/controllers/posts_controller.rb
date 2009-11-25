class PostsController < ApplicationController
  inherit_resources
  actions :all, :except => 'show'

  def admin
    @posts = Post.all(:order => 'id DESC')
  end

  def update
    update! do |success, failure|
      success.html { redirect_to admin_posts_path}
    end
  end

  def create
    create! do |success, failure|
      success.html { redirect_to admin_posts_path}
    end
  end

  
end
