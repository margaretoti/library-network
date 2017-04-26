class Checkout < ApplicationRecord
  CHECKOUT_PERIOD_IN_DAYS = 14
  FINE_AMOUNT_PER_DAY_IN_CENTS = 10

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true #, uniqueness: true
  validates :due_on, presence: true

  monetize :fine_cents

  def calculate_fine
    if overdue?
      number_of_days_overdue = days_overdue
      checkout_fine = fine_cents + number_of_days_overdue * FINE_AMOUNT_PER_DAY_IN_CENTS
    else
      checkout_fine = fine_cents
    end
    Money.new(checkout_fine)
  end

  def calculate_fine_including_related_checkouts
    book_checkouts = Checkout.where(user_id: self.user_id, book_id: self.book_id)
    total = book_checkouts.inject(Money.new(0)) { |total, book_checkout| total + book_checkout.calculate_fine }
    total
  end

  def overdue?
    if closed?
      false
    else
      days_overdue > 0
    end
  end

  private

  def days_overdue
    (Time.current - due_on).to_i / 1.day
  end

  def closed?
    closed_at.present?
  end
end
