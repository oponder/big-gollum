FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "password123"

    trait :admin do
      email "admin-user@example.com"
    end

    trait :normal do
      sequence(:email) { |n| "person#{n}@example.com" }
    end
  end
end
