module Features
  def have_checked_out_book(title)
    have_css('ul.books.unavailable li', text: title)
  end

  def have_unavailable_book(title)
    have_css('ul.books.unavailable li', text: title)
  end

  def have_returned_book(title)
    have_css('ul.books.available li', text: title)
  end

  def have_available_book(title)
    have_css('ul.books.available li', text: title)
  end
end
