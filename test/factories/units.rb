FactoryBot.define do
  factory :unit do
    name { "Troop #{rand(1000)} #{Faker::Address.city}, #{Faker::Address.state_abbr}" }
  end
end
