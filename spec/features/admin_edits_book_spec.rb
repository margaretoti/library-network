require 'rails_helper'

feature 'User edits an existing book' do
  scenario 'updates title and author field successfully' do
    book = create(:book)
    admin = create(:user, admin: true)
    visit root_path

    sign_in_with(admin.email, admin.password)
    edit_book(new_title: 'The Golden Compass', new_author: 'Philip Pullman')

    expect(page).to have_content(t('books.index.header'))
    expect(page).to have_content(t('books.update.flash_success'))
    expect(page).to have_content('The Golden Compass')
    expect(page).to have_content('Philip Pullman')
  end

  scenario 'updates title field with empty title unsuccessfully' do
    book = create(:book, author: 'Langston Hughes')
    admin = create(:user, admin: true)
    visit root_path

    sign_in_with(admin.email, admin.password)
    edit_book(new_title: '', new_author: book.author)

    expect(page).to have_content(t('books.edit.header'))
    expect(page).to have_content(t('books.validations.required'))
  end
end

feature 'Patron (non admin) cannot edit a book' do
  scenario 'ever' do
    book = create(:book)
    patron = create(:user, admin: false)

    sign_in_with(patron.email, patron.password)
    visit root_path

    expect(page).to have_content(t('books.index.header'))
    expect(page).not_to have_content(t('books.edit.link'))
  end
end

def edit_book(new_title:, new_author:)
  click_on t('books.edit.link')
  fill_in t('simple_form.labels.title'), with: new_title
  fill_in t('simple_form.labels.author'), with: new_author
  click_button t('books.update.button')
end