module BookHelper
  def delete_book_link(book)
    link_to t('.delete_link'),
      admin_book_path(book),
      method: :delete,
      data: { confirm: t('.delete_confirmation_text') }
  end
end
