FactoryGirl.define do
  factory :book do
    sequence :title do |n|
      "The Golden Compass #{n}"
    end
    author "Philip Pullman"
  end
end
