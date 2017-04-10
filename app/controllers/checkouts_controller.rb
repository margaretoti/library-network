class CheckoutsController < ApplicationController
  before_action :require_login, :allow_anyone

  def create
    @book = Book.find(params[:book_id])
    checkout = Checkout.create(book: @book, user: current_user)

    redirect_to root_path
  end
end
