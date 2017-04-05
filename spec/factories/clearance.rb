FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    name "Jon Smith"
    email
    password "password"

    factory :admin do
      admin true
    end

    factory :patron do
      admin false
    end
  end
end
