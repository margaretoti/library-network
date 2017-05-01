require 'rails_helper'
require 'date'

feature 'User can renew a checked out book' do
  scenario 'sucessfully' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)

    visit profile_path(as: patron)

    click_on t('profiles.show.renew_link')
    checkout.reload

    original_checkout_date = book.checkouts.first.created_at
    expected_due_date_after_renewal = format_date(original_checkout_date + (2 * Checkout::CHECKOUT_PERIOD_IN_DAYS.days))
    due_date_after_renewal = format_date(book.checkouts.last.due_on)
    expect(page).to have_due_date(due_date_after_renewal)
    expect(due_date_after_renewal).to eq(expected_due_date_after_renewal)
    expect(page).to have_content(t('renewals.create.successful_message'))
  end

  scenario 'prior fines are included when an overdue book is renewed' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)

    date_one_day_overdue = date_when_book_is_one_day_overdue(Time.current)
    Timecop.travel(date_one_day_overdue) do
      visit profile_path(as: patron)

      click_on t('profiles.show.renew_link')
      checkout.reload
    end

    expect(page).to have_fine_on_a_single_book_of('$0.10')
    expect(page).to have_total_fines_of('$0.10')
  end

  scenario 'prior fines carry over and accumulate if book is overdue again' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)

    date_overdue = date_when_book_is_one_day_overdue(Time.current)
    Timecop.travel(date_overdue) do
      visit profile_path(as: patron)

      click_on t('profiles.show.renew_link')
      checkout.reload
    end

    expect(page).to have_fine_on_a_single_book_of('$0.10')
    expect(page).to have_total_fines_of('$0.10')

    original_due_date = book.checkouts.first.due_on
    date_overdue_again = date_when_book_is_one_day_overdue(original_due_date)
    Timecop.travel(date_overdue_again) do
      visit profile_path(as: patron)
    end

    expect(page).to have_fine_on_a_single_book_of('$0.20')
    expect(page).to have_total_fines_of('$0.20')
  end

  def date_when_book_is_one_day_overdue(start_date)
    start_date + (Checkout::CHECKOUT_PERIOD_IN_DAYS + 1).days
  end

  def format_date(date)
    date.strftime("%b %-d, %Y")
  end

  def have_due_date(date)
    have_content(date)
  end
end
