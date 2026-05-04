FactoryBot.define do
  factory :vtuber_place do
    association :vtuber
    association :place
    url { "https://www.youtube.com/" }
  end
end
