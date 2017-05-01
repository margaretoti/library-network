require 'rails_helper'

feature 'User returns only books she borrowed from the library' do
  scenario 'successfully' do
    book_1 = create(:book)
    patron_1 = create(:patron)
    visit books_path(as: patron_1)
    click_on t('books.index.check_out_link')
    sign_out

    book_2 = create(:book)
    patron_2 = create(:patron)
    visit books_path(as: patron_2)
    expect(page).to have_unavailable_book(book_1.title)

    click_on t('books.index.check_out_link')
    visit profile_path(as: patron_2)
    expect(page).to have_css('table.checkouts td', text: book_2.title)

    click_on t('profiles.show.return_link')

    expect(page).to have_css('.checkouts-header', text: t('profiles.show.header'))
    expect(page).to have_no_content(book_2.title)
    expect(page).to have_no_content(book_1.title)
  end

  scenario 'accumulated fines are correctly reflected in total fines' do
    book = create(:book)
    patron = create(:patron)
    checkout = create(:checkout, user: patron, book: book)

    date_when_book_is_one_day_overdue = Time.current + (Checkout::CHECKOUT_PERIOD_IN_DAYS + 1).days
    Timecop.travel(date_when_book_is_one_day_overdue) do
      visit profile_path(as: patron)

      click_on t('profiles.show.return_link')
    end

    expect(page).to have_total_fines_of('0.10')
    expect(page).to have_no_content(book.title)
  end
end
