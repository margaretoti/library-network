class BooksController < ApplicationController
  before_action :allow_non_admin_only #:allow_anyone

  def index
    @books = Book.all
  end
end
