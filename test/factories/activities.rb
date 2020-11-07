FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence(word_count: 3) }
    author
    unit { author.unit }
  end
end
