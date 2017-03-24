require 'rails_helper'

feature 'User edits an existing book' do
  scenario 'updates title field successfully' do
    @book = create(:book)
    visit edit_book_path(@book)
    fill_in "Title", with: "The Golden Compass"
    click_button 'Save changes'
  end

  # scenario 'updates title and author fields successfully' do
  #   book = create(:book)
  #   visit edit_book_path(book)
  #   fill_in "Title", with: "The Amber Spyglass"
  #   fill_in "Author", with: "Philip Pullman"
  #   click_button 'Save changes'
  # end
end
