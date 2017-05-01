module Features
  def have_fine_on_a_single_book_of(dollar_amount)
    have_css('td.fine', text: dollar_amount)
  end

  def have_total_fines_of(dollar_amount)
    have_css('p.total_fines', text: dollar_amount)
  end

  def not_have_any_fines_of_zero_dollars
    have_no_content('$0.00')
  end
end
