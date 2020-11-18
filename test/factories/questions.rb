FactoryBot.define do
  factory :question do
    activity
    content { 'MyString' }
    user
  end
end
