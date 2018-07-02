FactoryBot.define do
  factory :poll do
    title "Example Poll"
    option_a "Choice 1"
    option_b "Choice 2"
    option_a_url ""
    option_b_url ""
    user
  end
end
