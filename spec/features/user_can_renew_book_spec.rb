require 'rails_helper'
require 'date'

feature 'User can renew a checked out book' do
  scenario 'sucessfully' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)

    puts "ORIGINALLY DUE ON:"
    puts checkout.due_on

    visit profile_path(as: patron)

    click_on 'Renew'

    puts "NEWLY DUE ON:"
    puts checkout.due_on

    expected_due_date_after_renewal = format_date(book.checkouts.first.created_at + Checkout::CHECKOUT_PERIOD_IN_DAYS.days)
    due_date_after_renewal = format_date(book.checkouts.first.due_on)

    # expect(page).to have_content('Renewals')
    expect(page).to have_content(due_date_after_renewal)
    expect(calculated_due_date_after_renewal).to eq(due_date_after_renewal)
  end

  # scenario 'unsucessfully if book is overdue' do
  # end
  #
  # scenario 'no more than twice' do
  # end

  def format_date(date)
    date.strftime("%b %-d, %Y")
  end
end
