require 'rails_helper'

feature 'User views profile page' do
  scenario 'and sees a list of checked out books and return links' do
    book = create(:book)
    patron = create(:patron)
    visit books_path(as: patron)
    click_on 'Check out'

    visit profile_path(patron)

    expect(page).to have_css('.checkouts-header', text: t('profiles.show.header'))
    expect(page).to have_css('table.checkouts td', text: book.title)
  end
end
