class ClipsController < AdminController
  inherit_resources
  belongs_to :group

  def index
    @clip = Clip.new
    index!
  end

  def create
    create! do |success, failure|
      success.html {redirect_to @group}
      failure.html { render :action => 'new'}
    end
    expire_section @clip.group
  end

  def update
    update! do |success, failure|
      success.html {redirect_to @group}
    end
      expire_section @clip.group
  end

  def destroy
    destroy! {redirect_to @group}
  end

  protected
  def begin_of_association_chain
    @group = Group.find_by_name(params[:group_id])
  end
end
