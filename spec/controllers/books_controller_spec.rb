require "rails_helper"

describe BooksController do
  describe '#index - GET/books' do
    it 'returns a list of all books' do
      books = create_list(:book, 5)

      get :index
      expect(response).to have_http_status :success
    end
  end

  describe '#create - POST/book' do
    it 'redirects to books#index after successfully saving the newly created
    book to the database' do

      book_params = {
        book: {
          title: "How to Bake Everything",
          author: "Mark Bittman"
        }
      }

      post :create, params: book_params
      expect(response).to have_http_status :redirect
    end
  end
end
