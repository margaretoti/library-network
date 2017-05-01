class ProfilesController < ApplicationController
  before_action :require_login, :allow_anyone

  def show
    @checkouts = current_user.checkouts.includes(:book).open
    render :show
  end
end
