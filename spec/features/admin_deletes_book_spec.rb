require 'rails_helper'

feature 'Admin deletes a book', js: true do
  scenario 'successfully' do
    book = create(:book)
    admin = create(:admin)
    visit admin_books_path(as: admin)

    delete_book

    expect(page).to have_content(t('admin.books.index.header'))
    expect(page).to have_content(t('admin.books.index.delete_flash_success'))
    expect(page).not_to have_content(book.title)
  end

  def delete_book
    accept_confirm t('admin.books.index.delete_confirmation_text') do
        click_on t('admin.books.index.delete_link')
    end
  end
end
