class BooksController < ApplicationController
  before_action :allow_anyone

  def index
    @books = Book.all
  end
end
