FactoryBot.define do
  factory :user do
    username "demouser"
    email "demouser@example.com"
    password "password"
    password_confirmation "password"
  end
end