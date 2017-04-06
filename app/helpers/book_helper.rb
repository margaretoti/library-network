module BookHelper
  def delete_book_link(book)
    link_to t('.delete.link'),
      admin_book_path(book),
      method: :delete,
      data: { confirm: t('.delete.confirmation_text') }
  end
end
