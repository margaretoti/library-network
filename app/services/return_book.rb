class ReturnBook
  def self.process(book_id:, user_id:)
    new(book_id: book_id, user_id: user_id).process
  end

  def initialize(book_id:, user_id:)
    @book_id = book_id
    @user_id = user_id
  end

  def process
    Checkout.where(book_id: @book_id, user_id: @user_id).destroy_all
  end

  private

  attr_reader :book_id, :user_id
end
