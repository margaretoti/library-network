class BooksController < ApplicationController
  before_action :allow_anyone

  def index
    @books = Book.all
    @available_books = @books.available
    @unavailable_books = @books.unavailable

    if params[:search]
      @books = Book.search(params[:search])
    else
      @books = Book.all
    end
  end
end
