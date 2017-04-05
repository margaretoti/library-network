class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  after_action :ensure_authorization_checked

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
    authorization_checked
  end

  def allow_anyone
    authorization_checked
  end

  def ensure_authorization_checked
    if authorization_unchecked?
      raise "Make sure to check authorization for #{self.class.name}"
    end
  end

  def authorization_unchecked?
    !@authorization_checked
  end

  def authorization_checked
    @authorization_checked = true
  end
end
