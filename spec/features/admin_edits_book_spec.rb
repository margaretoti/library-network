require 'rails_helper'

feature 'User edits an existing book' do
  scenario 'updates title and author field successfully' do
    book = create(:book)
    admin = create(:admin)
    visit admin_books_path(book, as: admin)

    edit_book(new_title: 'The Golden Compass', new_author: 'Philip Pullman')

    expect(page).to have_content(t('admin.books.index.header'))
    expect(page).to have_content(t('admin.books.update.flash_success'))
    expect(page).to have_content('The Golden Compass')
    expect(page).to have_content('Philip Pullman')
  end

  scenario 'updates title field with empty title unsuccessfully' do
    book = create(:book, author: 'Langston Hughes')
    admin = create(:admin)
    visit admin_books_path(book, as: admin)

    edit_book(new_title: '', new_author: book.author)

    expect(page).to have_content(t('admin.books.edit.header'))
    expect(page).to have_content(t('admin.books.validations.required'))
  end

  def edit_book(new_title:, new_author:)
    click_on t('admin.books.index.edit_link')
    fill_in t('simple_form.labels.title'), with: new_title
    fill_in t('simple_form.labels.author'), with: new_author
    click_button t('admin.books.update.button')
  end
end
