class Book < ApplicationRecord
  has_many :checkouts
  has_many :users, through: :checkouts

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :author, presence: true

  def self.unavailable
    Book.joins(:checkouts).where(checkouts: {closed_at: nil })
  end

  def self.available
    Book.joins(
      "LEFT JOIN
        (SELECT * FROM checkouts
          WHERE checkouts.closed_at IS NULL) open_checkouts
       ON books.id = open_checkouts.book_id
       WHERE open_checkouts.id IS NULL"
    )
  end

  def self.search(search)
    where("author ILIKE ? OR title ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
