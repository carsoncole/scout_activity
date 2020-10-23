FactoryBot.define do
  factory :user,aliases: [:author] do
    email { "MyString" }
    password { "Passsword"}
    troop
  end
end
