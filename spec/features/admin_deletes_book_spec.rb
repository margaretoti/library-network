require 'rails_helper'

feature 'Admin deletes a book', js: true do
  scenario 'successfully' do
    book = create(:book)
    admin = create(:admin)
    visit root_path(as: admin)

    delete_book

    expect(page).to have_content(t('books.index.header'))
    expect(page).to have_content(t('books.delete.flash_success'))
    expect(page).not_to have_content(book.title)
  end

  def delete_book
    accept_confirm t('books.delete.confirmation_text') do
        click_on t('books.delete.link')
    end
  end
end
