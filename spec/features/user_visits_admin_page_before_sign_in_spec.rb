require "rails_helper"

feature "User visits /admin/books url without first signing in" do
  scenario "redirected to sign in page" do
    visit admin_books_path

    expect(page).to have_css('h2', text: t('layouts.application.sign_in'))
  end
end
