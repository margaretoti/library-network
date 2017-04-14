require 'rails_helper'

feature 'User returns only books she borrowed from the library' do
  scenario 'successfully' do
    book_1 = create(:book)
    patron_1 = create(:patron)
    visit books_path(as: patron_1)
    click_on 'Check out'
    sign_out

    book_2 = create(:book)
    patron_2 = create(:patron)
    visit books_path(as: patron_2)
    expect(page).to have_unavailable_book(book_1.title)

    click_on 'Check out'
    visit profile_path(as: patron_2)
    expect(page).to have_css('ul.checkouts li', text: book_2.title)

    click_on 'Return'

    expect(page).to have_css('.checkouts-header', text: t('profiles.show.header'))
    expect(page).to have_no_content(book_2.title)
    expect(page).to have_no_content(book_1.title)
  end
end
