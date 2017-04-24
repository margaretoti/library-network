class Book < ApplicationRecord
  has_many :checkouts
  has_many :users, through: :checkouts

  validates :title, presence: true, uniqueness: { case_sensitive: false}
  validates :author, presence: true
  #
  # def self.available
  #   includes(:checkouts).where(checkouts: { id: nil })
  # end
  #
  # def self.unavailable
  #   includes(:checkouts).where.not(checkouts: { id: nil })
  # end

  def self.unavailable
    # includes(:checkouts).where(checkouts: { closed_at: nil })
    Book.joins(:checkouts).where(checkouts: {closed_at: nil })
  end

  def self.available
    #!unavailable
    #includes(:checkouts).none(checkouts: { closed_at: nil })
    #includes(:checkouts).where.not(checkouts: { closed_at: nil })

    Book.joins(
      "LEFT JOIN
        (SELECT * FROM checkouts
          WHERE checkouts.closed_at IS NULL) open_checkouts
       ON books.id = open_checkouts.book_id
       WHERE open_checkouts.id IS NULL"
    )

    #includes(:checkouts)

    #
    # checkouts = includes(:checkouts)
    # all_nil = true
    # checkouts.each do |checkout|
    #   if checkout.closed_at = nil
    #     all_nil = true
    #   else
    #     all_nil = false
    #     break
    #   end
    # end
    # if all_nil = true
    #   checkouts
    # else
    #   puts "no checkouts"
    # end
  end
end
