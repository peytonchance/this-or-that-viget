FactoryBot.define do
  factory :user do
    password "password"
    password_confirmation "password"
    
    sequence(:username) { |n| "demouser#{n}" }
    sequence(:email) { |n| "demouser#{n}@example.com" }
  end
end