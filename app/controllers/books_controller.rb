class BooksController < ApplicationController
  before_action :allow_anyone, only: :index

  def index
    @books = Book.all
  end
end 
