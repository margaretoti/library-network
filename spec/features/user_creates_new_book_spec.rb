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
  click_on t('books.index.add_new_book_link')
  fill_in t('simple_form.labels.title'), with: title
  fill_in t('simple_form.labels.author'), with: author
  click_on "Create Book"
end
