FactoryBot.define do
  factory :vtuber do
    name { Faker::Name.name }
    image { Faker::Name.name }
    debut_date { Faker::Date.in_date_period }
    # fan_name {}
    like { Faker::Name.name }
    unlike { Faker::Name.name }
    # frequency_id {}
    gender { Faker::Gender.type }
    name_x { Faker::Alphanumeric.alpha(number: 10) }
    affiliation { Faker::Name.name }
    birthday { Faker::Date.in_date_period }
    version { 0 }
    favorites_count { 0 }
    language { "JP" }
    height { 160 }
    blood_type { Faker::Blood.type }
  end
end
