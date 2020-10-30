FactoryBot.define do
  factory :answer do
    question { nil }
    content { "MyText" }
    user { nil }
  end
end
