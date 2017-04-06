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
      flash[:success] = t('admin.books.create.flash_success')
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = t('admin.books.update.flash_success')
      redirect_to admin_books_path
    else
      render :edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = t('admin.books.index.delete_flash_success')
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
