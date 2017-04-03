class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
