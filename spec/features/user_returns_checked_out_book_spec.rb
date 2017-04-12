require "rails_helper"

feature "User returns only books she borrowed from the library" do
  scenario "successfully" do
    book_1 = create(:book)
    patron_1 = create(:patron)
    visit books_path(as: patron_1)
    click_on "Check out"
    sign_out

    book_2 = create(:book)
    patron_2 = create(:patron)
    visit books_path(as: patron_2 )
    click_on "Check out"
    click_on "Return"

    expect(page).to have_returned_book(book_2.title)
    expect(page).to have_checked_out_book(book_1.title)
    expect(page).to have_no_link("Return")
  end
end
