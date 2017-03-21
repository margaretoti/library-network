module Features
  def create_book(book_title, book_author)
    click_on "Add a new book"
    fill_in "Title", with: book_title
    fill_in "Author", with: book_author
    click_on "Create Book"
  end 
end
