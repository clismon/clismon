class PostsController < ApplicationController
  inherit_resources
  actions :all, :except => 'show'

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
