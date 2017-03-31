class UsersController < Clearance::UsersController
  def user_params
    params[:user]&.permit(:email, :password, :name) || Hash.new
  end
end
