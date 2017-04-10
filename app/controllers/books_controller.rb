class BooksController < ApplicationController
  before_action :allow_anyone

  def index
    @books = Book.all
    @available_books = @books.available
    @unavailable_books = @books.unavailable
  end
end
