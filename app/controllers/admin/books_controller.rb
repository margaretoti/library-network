class Admin::BooksController < ApplicationController
  before_action :require_login, :require_admin

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path, success: t('.create.flash_success')
    else
      render :new
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      redirect_to admin_books_path, success: t('.update.flash_success')
    else
      render :edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to admin_books_path, success: t('.index.delete_flash_success')
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
