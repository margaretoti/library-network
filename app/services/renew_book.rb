class RenewBook
  def self.process(checkout)
    new(checkout).process
  end

  def initialize(checkout)
    @checkout = checkout
  end

  def process
    due_on = @checkout.due_on + Checkout::CHECKOUT_PERIOD_IN_DAYS.days
    @checkout.update!(due_on: due_on)
  end

  private

  attr_reader :checkout
end
