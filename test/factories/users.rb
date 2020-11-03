FactoryBot.define do
  factory :user,aliases: [:author] do
    email { Faker::Internet.email }
    password { "Passsword"}
    unit
  end
end
