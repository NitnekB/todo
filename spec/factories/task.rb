FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.sentences }
    state { Task::STATES.sample }

    project
  end
end
