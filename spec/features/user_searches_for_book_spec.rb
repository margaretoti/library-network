require 'rails_helper'

feature 'User searches for a specific book' do
  scenario 'successfully' do
    searched_book = create(:book, title: 'The Giver')
    other_book = create(:book, title: 'Of Mice and Men')
    visit books_path

    fill_in 'search', with: searched_book.title
    click_on t('books.search.submit')

    expect(page).to have_results(searched_book.title)
    expect(page).not_to have_results(other_book.title)
  end

  def have_results(title)
    have_css('ul.search_results li', text: title)
  end
end
