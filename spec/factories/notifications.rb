FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    association :vtuber
    action { "update" }
    read_at { nil }
  end
end
