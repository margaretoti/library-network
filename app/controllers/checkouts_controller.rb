class CheckoutsController < ApplicationController
  before_action :require_login, :allow_anyone

  def create
    @book = Book.find(params[:book_id])
    @book.borrow(user: current_user)
    
    # checkout = Checkout.create(book: @book, user: current_user, due_on: DateTime.now + Checkout::CHECKOUT_PERIOD_IN_DAYS.days)

    redirect_to root_path
  end

  def update
    @checkout = Checkout.find(params[:id])
    # puts @checkout.due_on
    # @checkout.update(due_on: @checkout.due_on + Checkout::CHECKOUT_PERIOD_IN_DAYS.days)
    # puts @checkout.due_on
    @checkout.renew

    redirect_to profile_path
  end

  def destroy
    Checkout.where(user_id: current_user, book_id: params[:book_id]).destroy_all

    redirect_to profile_path
  end

  # def checkout_params_for_update
  #   params.require(:checkout).permit(:due_on)
  # end
end
