FactoryBot.define do
  factory :visitor_vote do
    ip_address "127.0.0.1"
    poll
    option 0
  end
end
