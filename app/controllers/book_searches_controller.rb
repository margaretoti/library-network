class BookSearchesController < ApplicationController
  before_action :allow_anyone

  def show
    @book_results = Book.search(params[:search])
    render :index
  end
end
