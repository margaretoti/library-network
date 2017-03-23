FactoryGirl.define do
  factory :book do
    sequence :title do |n|
      "Book Title #{n}"
    end

    author "Book Author"
  end
end
