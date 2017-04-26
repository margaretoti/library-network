class ProfilesController < ApplicationController
  before_action :require_login, :allow_anyone

  def show
    @checkouts = current_user.checkouts.includes(:book).where(closed_at: nil)
    render :show
  end
end
