FactoryBot.define do
  factory :log do
    user_id { 1 }
    unit_it { 1 }
    mailer_instance { "MyString" }
    message { "MyString" }
  end
end
