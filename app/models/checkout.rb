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
    number_of_days_overdue = days_overdue
    total_fine_for_book = fine_cents
    if overdue?
      total_fine_for_book += FINE_AMOUNT_PER_DAY_IN_CENTS * number_of_days_overdue
      puts "number of days overdue #{number_of_days_overdue}"
    end
    puts "fines are #{fine_cents} and #{total_fine_for_book}"
    Money.new(total_fine_for_book)
  end

  def overdue?
    if closed_at.present? # checkout is not overdue if it has been closed
      false
    else
      days_overdue > 0 ? true : false
    end
  end

  private

  def days_overdue
    (Time.zone.now - self.due_on).to_i/1.day
  end
end
