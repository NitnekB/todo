FactoryBot.define do
  factory :workspace do
    label { "Personal" }
    description { "Personal workspace" }
    context { "friends" }
    public { true }
  end
end
