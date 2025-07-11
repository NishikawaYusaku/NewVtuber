FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    name {Faker::Name.name}
    password {Faker::Internet.password(min_length: 8)}
    password_confirmation {password}
    agreement {"1"}
    reset_password_token {nil}
  end
end