require 'rails_helper'
require 'date'

feature 'User sees fine amounts for individual overdue books and the total fines owed for all books' do
  scenario 'sucessfully' do
    patron = create(:patron)
    book = create(:book)
    checkout = create(:checkout, user: patron, book: book)
    visit profile_path(as: patron)

    date_when_book_is_one_day_overdue = Time.current + (Checkout::CHECKOUT_PERIOD_IN_DAYS + 1).days
    Timecop.travel(date_when_book_is_one_day_overdue) do
      visit profile_path(as: patron)
    end
    expect(page).to have_column_header(t('profiles.show.fine'))
    expect(page).to have_fine_on_a_single_book_of('$0.10')
    expect(page).to have_content(t('profiles.show.fine_total'))
    expect(page).to have_total_fines_of('$0.10')
    # expect(page).to not_have_any_fines_of_zero_dollars
  end

  def have_column_header(header_title)
    have_css('table.checkouts td', text: header_title)
  end

  def have_fine_on_a_single_book_of(dollar_amount)
    have_css('td.fine', text: dollar_amount)
  end

  def have_total_fines_of(dollar_amount)
    have_css('p.total_fines', text: dollar_amount)
  end

  def not_have_any_fines_of_zero_dollars
    have_no_content('$0.00')
  end
end
