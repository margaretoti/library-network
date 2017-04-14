require 'rails_helper'
require 'date'

feature 'User sees a list of checked out books and their due dates' do
  scenario 'on profile page successfully' do
    book = create(:book)
    patron = create(:patron)
    visit books_path(as: patron)
    click_on t('books.index.check_out_link')

    visit profile_path(as: patron)

    # binding.pry
    formatted_date = format_date(Checkout.first.due_date)
    expect(page).to have_content(formatted_date)
  end

  def format_date(date)
    date.strftime("%b %-d, %Y")
  end
end
