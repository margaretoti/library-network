class BookFineCalculator
  def self.including_related_checkouts(checkout)
    new(checkout).including_related_checkouts
  end

  def initialize(checkout)
    @checkout = checkout
  end

  def including_related_checkouts
    sum = checkouts_for_book
          .inject(Money.new(0)) { |sum, checkout| sum + CheckoutFineCalculator.for(checkout) }
  end

  private

  attr_reader :checkout

  def checkouts_for_book
    Checkout.where(user_id: @checkout.user_id, book_id: @checkout.book_id)
  end
end
