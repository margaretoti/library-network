class CheckoutsController < ApplicationController
  before_action :require_login, :allow_anyone

  def create
    @book = Book.find(params[:book_id])
    CheckOutBook.process(book: @book, user: current_user)
    redirect_to root_path, success: t('.successful_message')
  end

  def update
    @checkout = Checkout.find(params[:id])
    RenewBook.process(@checkout)
    redirect_to profile_path, success: t('.successful_message')
  end

  def destroy
    ReturnBook.process(book_id: params[:book_id], user_id: current_user)
    redirect_to profile_path
  end
end
