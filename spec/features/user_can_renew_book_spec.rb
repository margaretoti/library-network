require 'rails_helper'
require 'date'

feature 'User can renew a checked out book' do
  scenario 'sucessfully' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)

    visit profile_path(as: patron)

    click_on 'Renew'

    checkout.reload

    expected_due_date_after_renewal = format_date(book.checkouts.first.created_at + (2 * Checkout::CHECKOUT_PERIOD_IN_DAYS.days))
    due_date_after_renewal = format_date(book.checkouts.first.due_on)
    expect(page).to have_due_date(due_date_after_renewal)
    expect(due_date_after_renewal).to eq(expected_due_date_after_renewal)
  end

  # scenario 'unsucessfully if book is overdue' do
  # end
  #
  # scenario 'no more than twice' do
  # end

  def format_date(date)
    date.strftime("%b %-d, %Y")
  end

  def have_due_date(date)
    have_content(date)
  end
end
