class Checkout < ApplicationRecord
  CHECKOUT_PERIOD_IN_DAYS = 14

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true, uniqueness: true

  def due_date
    self.created_at + CHECKOUT_PERIOD_IN_DAYS.days
  end
end
