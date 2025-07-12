FactoryBot.define do
  factory :vtuber_place do
    association :vtuber
    association :place
    url {Faker::Internet.url}
  end
end
