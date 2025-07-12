FactoryBot.define do
  factory :tag do
    name {Faker::Emotion.noun}
  end
end
