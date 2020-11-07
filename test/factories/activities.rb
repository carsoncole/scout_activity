FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence(word_count: 3) }
    author
    unit { author.unit }
    summary_new { Faker::Lorem.sentence(word_count: 10) }
  end
end
