FactoryBot.define do
  factory :user do
    sequence(:username, 1) { |n| "Roxy#{n}" }
  end
end