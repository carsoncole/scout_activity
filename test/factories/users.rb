FactoryBot.define do
  factory :user,aliases: [:author] do
    email { Faker::Internet.email }
    password { "Passsword"}
    troop
  end
end
