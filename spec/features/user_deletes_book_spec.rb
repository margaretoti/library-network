require 'rails_helper'

feature 'User deletes a book', js: true do
  scenario 'successfully' do
    book = create(:book)
    visit root_path

    expect {
      accept_confirm 'Are you sure?' do
        click_on 'Delete'
      end
    }.to change(Book, :count).by(-1)
    expect(page.current_path).to eq root_path
  end
end
