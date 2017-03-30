require 'rails_helper'

feature 'Admin deletes a book', js: true do
  scenario 'successfully' do
    book = create(:book)
    admin = create(:user, admin: true)

    sign_in_with(admin.email, admin.password)
    visit root_path

    expect(page).to have_content(t('books.delete.link'))

    delete_book

    expect(page).to have_content(t('books.index.header'))
    expect(page).to have_content(t('books.delete.flash_success'))
    expect(page).not_to have_content(book.title)
  end
end

feature 'Patron (non admin) cannot delete a book' do
  scenario 'ever' do
    book = create(:book)
    patron = create(:user, admin: false)

    sign_in_with(patron.email, patron.password)
    visit root_path

    expect(page).to have_content(t('books.index.header'))
    expect(page).not_to have_content(t('books.delete.link'))

  end
end

def delete_book
  accept_confirm t('books.delete.confirmation_text') do
      click_on t('books.delete.link')
  end
end
