FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    name "Jon Smith"
    admin false
    email
    password "password"
  end
end
