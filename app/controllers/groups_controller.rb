class GroupsController < ApplicationController
  layout 'admin'
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
    expire_section @group
  end

  private
  def load_groups
    @groups = Group.all
  end
end
