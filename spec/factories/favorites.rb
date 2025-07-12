FactoryBot.define do
  factory :favorite do
    association :user
    association :vtuber
  end
end
