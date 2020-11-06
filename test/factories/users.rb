FactoryBot.define do
  factory :user,aliases: [:author] do
    email { Faker::Internet.email }
    password { "Passsword"}
    unit

    factory :owner_user do
      is_owner { true }
    end
  end
end
