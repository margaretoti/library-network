class Book < ApplicationRecord
  has_many :checkouts
  has_many :users, through: :checkouts

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :author, presence: true

  def self.unavailable
    Book.joins(:checkouts).where(checkouts: {closed_at: nil })
  end

  def self.available
    # I used a LEFT JOIN because
    # Book.joins(:checkouts).where.not(checkouts: {closed_at: nil })
    # displayed books as available if ANY of the checkouts associated
    # with that book_id and user_id where marked as closed. I need
    # books to be listed as available only if EVERY checkout is marked
    # as closed.
    #
    # Details: The inner query finds all checkouts yet to be returned.
    # Then I join them with all books. Using a LEFT JOIN means that
    # if a book is not checked out, it will still be included in the
    # results table, just with nil values for the checkout.

    Book.joins(
      "LEFT JOIN
        (SELECT * FROM checkouts
          WHERE checkouts.closed_at IS NULL) open_checkouts
       ON books.id = open_checkouts.book_id
       WHERE open_checkouts.id IS NULL"
    )
  end
end
