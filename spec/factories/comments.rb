FactoryBot.define do
  factory :comment do
    association :user
    association :vtuber
    body {Faker::Lorem.sentence(word_count: 30)}
  end
end
