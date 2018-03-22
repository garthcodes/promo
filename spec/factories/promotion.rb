FactoryBot.define do
  factory :promotion do
    sequence(:code, 1) { |n| "Save#{n}" }
    sequence(:internal_message, 1) { |n| "Internal message is 20 and #{n}" }
    start_date Date.today
    end_date 10.days.from_now
    discount 2000
    user_message "You save $20 congratulations"
  end

  factory :assigned_promotion, parent: :promotion do
    assigned true
    after(:create) do |promo|
      promo.users << create(:user)
    end
  end

  factory :expired_promotion, parent: :promotion do
    start_date 10.days.ago
    end_date 2.days.ago
  end

  factory :not_started_promotion, parent: :promotion do
    start_date 10.days.from_now
    end_date 14.days.from_now
  end
end
