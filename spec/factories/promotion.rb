FactoryBot.define do
  factory :promotion do
    sequence(:code, 1) { |n| "Save#{n}" }
    sequence(:internal_message, 1) { |n| "Internal message#{n}" }
    start_date Date.today
    end_date 10.days.from_now
    discount 2000
    user_message "You save $20"
  end

  factory :assigned_promotion, parent: :promotion do
    assigned true
    after(:create) do |promo|
      promo.users << create(:user)
    end
  end
end
