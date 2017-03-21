require "rails_helper"

feature 'User creates a new book' do
  scenario 'successfully' do
    visit root_path

    create_book("The Lord of the Rings: The Fellowship of the Ring", "J. R. R. Tolkien" )

    expect(page).to have_css('.books li',
                    text: 'The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_css('.books li', text: 'J. R. R. Tolkien')
  end
end
