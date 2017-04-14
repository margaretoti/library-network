class ProfilesController < ApplicationController
  before_action :require_login, :allow_anyone

  def show
    @checkouts = current_user.checkouts
    
    render :show
  end
end
