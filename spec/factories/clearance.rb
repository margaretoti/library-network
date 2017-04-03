FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    name "Jon Smith"
    email
    password "password"

    trait :admin do
      admin true
    end

    trait :patron do
      admin false
    end
  end
end
