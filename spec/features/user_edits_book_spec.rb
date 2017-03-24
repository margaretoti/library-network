require 'rails_helper'

feature 'User edits an existing book' do
  scenario 'updates title field successfully' do
    @book = create(:book)
    visit root_path

    edit_book(@book, new_title: 'The Golden Compass',
                     new_author: @book.author)

    expect(page.current_path).to eq books_path
  end

  scenario 'updates title and author fields successfully' do
    @book = create(:book)
    visit root_path

    edit_book(@book, new_title: 'The Amber Spyglass',
                     new_author: 'Philip Pullman')

    expect(page.current_path).to eq books_path
  end

  def edit_book(book, options={})
    click_on 'Edit'
    visit edit_book_path(book)
    fill_in 'Title', with: options[:new_title]
    fill_in 'Author', with: options[:new_author]
    click_button 'Save changes'
  end
end
