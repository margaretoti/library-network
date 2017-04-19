FactoryGirl.define do
  factory :book do
    sequence :title do |n|
      "Book Title #{n}"
    end

    author "Book Author"
  end

  factory :checkout do
    user
    book
    due_on DateTime.now + Checkout::CHECKOUT_PERIOD_IN_DAYS.days
  end
end
