FactoryBot.define do
  factory :user,aliases: [:author] do
    email { Faker::Internet.email }
    password { "Passsword"}
    unit

    factory :owner_user do
      is_owner { true }
    end

    factory :admin_user do
      is_admin { true }
    end

    factory :app_admin_user do
      is_app_admin { true }
    end
  end
end
