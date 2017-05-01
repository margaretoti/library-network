class Checkout < ApplicationRecord
  CHECKOUT_PERIOD_IN_DAYS = 14
  FINE_AMOUNT_PER_DAY_IN_CENTS = 10

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates_uniqueness_of :book, conditions: -> { where(closed_at: nil) }
  validates :due_on, presence: true

  monetize :fine_cents

  def self.open
    where(closed_at: nil)
  end

  def overdue?
    if closed?
      false
    else
      days_overdue > 0
    end
  end

  def days_overdue
    (Time.current - due_on).to_i / 1.day
  end

  private

  def closed?
    closed_at.present?
  end
end
