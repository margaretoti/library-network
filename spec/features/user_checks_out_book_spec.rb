require "rails_helper"

feature "User borrows a book from the library" do
  scenario "successfully" do
    book = create(:book)
    patron = create(:patron)
    visit books_path(as: patron)

    expect(page).to have_available_book(book.title)
    expect(page).not_to have_checked_out_book(book.title)

    click_on t('books.index.check_out_link')

    expect(page).to have_checked_out_book(book.title)
    expect(page).not_to have_available_book(book.title)
    expect(page).to have_content(t('checkouts.create.successful_message'))
  end
end
