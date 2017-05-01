class ReturnBook
  def self.process(book_id:, user_id:)
    new(book_id: book_id, user_id: user_id).process
  end

  def initialize(book_id:, user_id:)
    @book_id = book_id
    @user_id = user_id
  end

  def process
    book_fine = CheckoutFineCalculator.for(last_checkout)

    last_checkout.update!(fine: book_fine, closed_at: Time.current)
  end

  private

  attr_reader :book_id, :user_id

  def last_checkout
    checkouts = Checkout.where(book_id: @book_id, user_id: @user_id, closed_at: nil)
    ordered_checkouts = checkouts.order(id: :asc)
    ordered_checkouts.last
  end
end
