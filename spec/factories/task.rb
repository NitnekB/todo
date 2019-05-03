FactoryBot.define do
  factory :task do
    title { "My new task" }
    content { "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum." }
    state { "TODO" }

    project
  end
end
