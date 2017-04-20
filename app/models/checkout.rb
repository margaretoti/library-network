class Checkout < ApplicationRecord
  CHECKOUT_PERIOD_IN_DAYS = 14
  FINE_AMOUNT_PER_DAY_IN_CENTS = 0.10

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true, uniqueness: true
  validates :due_on, presence: true

  def fine
    number_of_days_overdue = days_overdue
    if overdue?
      fine = FINE_AMOUNT_PER_DAY_IN_CENTS * days_overdue
    else
      fine = 0
    end
  end

  def overdue?
    number_of_days_overdue = days_overdue
    number_of_days_overdue > 0 ? true : false
  end

  private

  def days_overdue
    (Time.zone.now - self.due_on).to_i/1.day
  end
end
