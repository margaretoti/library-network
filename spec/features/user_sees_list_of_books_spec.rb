require 'rails_helper'

feature 'User sees a list of books' do
  scenario 'successfully' do
    books = create_pair(:book)
    visit books_path

    books.each do |book|
      expect(page).to have_css('.books', text: book.title)
    end
  end
end
