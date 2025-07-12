FactoryBot.define do
  factory :vtuber_user do
    association :user
    association :vtuber
  end
end
