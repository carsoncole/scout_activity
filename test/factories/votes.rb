FactoryBot.define do
  factory :vote do
    activity
    user { activity&.user }
  end
end
