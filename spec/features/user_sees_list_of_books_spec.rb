require "rails_helper"

feature 'User sees a list of books' do
  scenario 'successfully' do

    books = create_list(:book, 3)

    visit books_path

    expect(page).to have_css('ul.books', :count => 1)
    expect(page).to have_css('.books li', :count => 3)
  end
end
