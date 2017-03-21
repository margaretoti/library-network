require "rails_helper"

feature 'User creates a new book' do
  scenario 'successfully' do
    visit root_path

    click_on "Add a new book"
    fill_in "Title", with: "The Lord of the Rings: The Fellowship of the Ring"
    fill_in "Author", with: "J. R. R. Tolkien"
    click_on "Create Book"

    expect(page).to have_css('.books li', text: 'The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_css('.books li', text: 'J. R. R. Tolkien')
  end
end
