require 'rails_helper'

feature 'User creates a new book' do
  scenario 'successfully' do
    visit root_path

    create_book('The Fellowship of the Ring', 'J. R. R. Tolkien' )

    expect(page).to have_css('.books', text: 'The Fellowship of the Ring')
    expect(page).to have_css('.books', text: 'J. R. R. Tolkien')
  end
end

def create_book(title, author)
  click_on "Add a new book"
  fill_in "Title", with: title
  fill_in "Author", with: author
  click_on "Create Book"
end
