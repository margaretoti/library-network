require 'rails_helper'
require 'date'

feature 'User sees a table of books, each with a checkout date and due date' do
  scenario 'on profile page successfully' do
    book = create(:book)
    patron = create(:patron)
    visit books_path(as: patron)
    click_on t('books.index.check_out_link')

    visit profile_path(as: patron)

    formatted_checkout_date = format_date(book.checkouts.first.created_at)
    formatted_due_date = format_date(book.checkouts.first.due_date)

    expect(page).to have_css('td', text: t('profiles.show.checkout_date'))
    expect(page).to have_content(formatted_checkout_date)
    expect(page).to have_css('td', text: t('profiles.show.due_date'))
    expect(page).to have_content(formatted_due_date)
  end

  def format_date(date)
    date.strftime("%b %-d, %Y")
  end
end
