class CheckOutBook
  def self.process(book:, user:)
    new(book: book, user: user).process
  end

  def initialize(book:, user:)
    @book = book
    @user = user
  end

  def process
    due_date = DateTime.now + Checkout::CHECKOUT_PERIOD_IN_DAYS.days
    Checkout.create!(book: @book, user: @user, due_on: due_date)
  end

  private

  attr_reader :book, :user
end
