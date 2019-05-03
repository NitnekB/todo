FactoryBot.define do
  factory :workspace do
    label { Faker::Lorem.sentence }
    description { Faker::Lorem.sentences }
    context { Faker::Lorem.words }
    public { true }
  end
end
