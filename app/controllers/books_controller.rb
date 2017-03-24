class BooksController < ApplicationController
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
      flash[:success] = t('books.create.flash_success')
      redirect_to books_path
    else
      render :new
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = t('books.update.flash_success')
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = t('books.delete.flash_success')
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
