FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence(word_count: 3) }
    author
    unit { author.unit }
    summary_new { Faker::Lorem.sentence(word_count: 10) }

    factory :troop_activity do
      is_troop { true }
    end
  end
end
