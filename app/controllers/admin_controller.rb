# To change this template, choose Tools | Templates
# and open the template in the editor.

class AdminController < ApplicationController
  layout 'admin'
  before_filter :load_groups, :authenticate

  private
  def load_groups
    @groups = Group.all
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG['username'] && password == APP_CONFIG['password']
    end
  end
end
