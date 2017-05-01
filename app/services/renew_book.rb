class RenewBook
  def self.process(checkout:, user:)
    new(checkout: checkout, user: user).process
  end

  def initialize(checkout:, user:)
    @checkout = checkout
    @user = user
  end

  def process
    book_fine = CheckoutFineCalculator.for(@checkout)

    ApplicationRecord.transaction do
      @checkout.update!(closed_at: Time.current, fine: book_fine)
      Checkout.create!(book: find_book(@checkout),
                       user: @user,
                       due_on: calculate_due_date(@checkout),
                       fine_cents: 0)
    end 
  end

  private

  attr_reader :checkout

  def find_book(checkout)
    Book.find(checkout.book_id)
  end

  def calculate_due_date(checkout)
    @checkout.due_on + Checkout::CHECKOUT_PERIOD_IN_DAYS.days
  end
end
