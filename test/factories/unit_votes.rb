FactoryBot.define do
  factory :unit_vote do
    activity
    user { association :user, unit: activity.unit }
  end
end
