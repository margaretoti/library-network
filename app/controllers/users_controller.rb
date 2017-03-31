class UsersController < Clearance::UsersController
  before_action :allow_anyone
  
  def user_params
    params[:user]&.permit(:email, :password, :name) || Hash.new
  end
end
