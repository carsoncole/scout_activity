FactoryBot.define do
  factory :activity do
    name { "MyString" }
    author
    unit { author.unit }
  end
end
