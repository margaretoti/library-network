require 'rails_helper'
require 'date'

feature 'User sees fine amounts for overdue books' do
  scenario 'sucessfully' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)
    visit profile_path(as: patron)

    date_when_book_is_one_day_overdue = DateTime.now + (Checkout::CHECKOUT_PERIOD_IN_DAYS + 1).days
    Timecop.travel(date_when_book_is_one_day_overdue) do
      visit profile_path(as: patron)
    end

    expect(page).to have_content('$0.10')
    expect(page).to have_css('td', text: t('profiles.show.fines'))
  end
end
