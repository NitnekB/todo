FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.sentences }
    state { Faker::Lorem.word }

    project
  end
end
