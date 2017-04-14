class Checkout < ApplicationRecord
  CHECKOUT_PERIOD_IN_DAYS = 14
  # GRACE_PERIOD_IN_DAYS = 1

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true, uniqueness: true

  def due_date
    self.created_at + CHECKOUT_PERIOD_IN_DAYS.day
  end
end
