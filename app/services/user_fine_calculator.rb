class UserFineCalculator
  def self.total(user)
    new(user).total
  end

  def initialize(user)
    @user = user
  end

  def total
    total = user_checkouts.inject(0) { |total, checkout| total + CheckoutFineCalculator.for(checkout) }
    total = sprintf('%.2f', total)
  end

  private

  attr_reader :user

  def user_checkouts
    @user.checkouts
  end
end
