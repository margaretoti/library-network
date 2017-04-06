require 'rails_helper'

feature 'Admin creates a new book' do
  scenario 'successfully' do
    admin = create(:admin)
    visit root_path(as: admin)

    create_book('The Fellowship of the Ring', 'J. R. R. Tolkien')

    expect(page).to have_content(t('admin.books.index.header'))
    expect(page).to have_content(t('admin.books.create.flash_success'))
    expect(page).to have_css('.books', text: 'The Fellowship of the Ring')
    expect(page).to have_css('.books', text: 'J. R. R. Tolkien')
  end

  scenario "unsuccessfully - required field is missing" do
    admin = create(:admin)
    visit root_path(as: admin)

    create_book('The Two Towers', '')

    expect(page).to have_content(t('admin.books.new.header'))
    expect(page).to have_content(t('admin.books.validations.required'))
  end

  def create_book(title, author)
    click_on t('admin.books.index.add_new_book_link')
    fill_in t('simple_form.labels.title'), with: title
    fill_in t('simple_form.labels.author'), with: author
    click_button t('admin.books.create.button')
  end
end
