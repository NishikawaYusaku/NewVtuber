FactoryBot.define do
  factory :vtuber_tag do
    association :vtuber
    association :tag
  end
end
