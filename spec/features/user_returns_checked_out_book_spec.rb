require "rails_helper"

feature "User returns only books she borrowed from the library" do
  scenario "successfully" do
    patron_1 = create(:patron)
    book_1 = create(:book)
    visit books_path(as: patron_1)
    click_on "Check out"
    sign_out
    patron_2 = create(:patron)
    book_2 = create(:book)
    visit books_path(as: patron_2)
    click_on "Check out"

    click_on "Return"

    expect(page).to have_returned_book(book_2.title)
    expect(page).not_to have_unavailable_book(book_2.title)
    expect(page).to have_checked_out_book(book_1.title)
  end

  # spec/support/features/check_out_return.rb in Features module
  def have_checked_out_book(title)
    have_css('ul.books.unavailable li', text: title)
  end

  def have_unavailable_book(title)
    have_css('ul.books.unavailable li', text: title)
  end

  def have_returned_book(title)
    have_css('ul.books.available li', text: title)
  end
end
