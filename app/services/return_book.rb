class ReturnBook
  def self.process(book_id:, user_id:)
    new(book_id: book_id, user_id: user_id).process
  end

  def initialize(book_id:, user_id:)
    @book_id = book_id
    @user_id = user_id
  end

  def process
    checkout = Checkout.where(book_id: @book_id, user_id: @user_id).last
    book_fine = checkout.calculate_fine

    checkout.update!(fine: book_fine, closed_at: Time.current)
  end

  private

  attr_reader :book_id, :user_id
end
