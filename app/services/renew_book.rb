class RenewBook
  def self.process(checkout:, user:)
    new(checkout: checkout, user: user).process
  end

  def initialize(checkout:, user:)
    @checkout = checkout
    @user = user
  end

  def process
    book = Book.find(@checkout.book_id)
    due_date = @checkout.due_on + Checkout::CHECKOUT_PERIOD_IN_DAYS.days
    book_fine = @checkout.calculate_fine

    closed_at = DateTime.now
    @checkout.update!(closed_at: closed_at, fine_cents: 0)

    Checkout.create!(book: book, user: @user, due_on: due_date, fine: book_fine )
  end

  private

  attr_reader :checkout
end
