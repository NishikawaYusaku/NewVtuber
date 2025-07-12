FactoryBot.define do
  factory :vtuber_content do
    association :vtuber
    association :content
  end
end
