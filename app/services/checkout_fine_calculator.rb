class CheckoutFineCalculator
  def self.for(checkout)
    new(checkout).for
  end

  def initialize(checkout)
    @checkout = checkout
  end

  def for
    fine_for_a_single_checkout
  end

  private

  attr_reader :checkout

  def fine_amount
    Checkout::FINE_AMOUNT_PER_DAY_IN_CENTS
  end

  def fine_for_a_single_checkout
    if @checkout.overdue?
      checkout_fine = @checkout.fine_cents + (@checkout.days_overdue * fine_amount)
    else
      checkout_fine = @checkout.fine_cents
    end
    Money.new(checkout_fine)
  end
end
