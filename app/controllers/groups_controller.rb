class GroupsController < ApplicationController
  layout 'posts'
  before_filter :load_groups
  inherit_resources


  def show
    @group = Group.find_by_name(params[:id])
    show!
  end

  def edit
    @group = Group.find_by_name(params[:id])
    show!
  end

  def update
    @group = Group.find_by_name(params[:id])
    update!
  end

  private
  def load_groups
    @groups = Group.all
  end
end