class RenewalsController < ApplicationController
  before_action :require_login, :allow_anyone

  def create
    @checkout = Checkout.find(params[:checkout_id])
    RenewBook.process(checkout: @checkout, user: current_user)
    redirect_to profile_path, success: t('.successful_message')
  end
end
