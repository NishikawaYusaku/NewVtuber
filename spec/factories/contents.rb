FactoryBot.define do
  factory :content do
    name { Faker::Job.field }
  end
end
