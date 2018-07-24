desc "Detects polls that are expired based on given time and sets them to expired"

task detect_expired_polls: :environment do
  Poll.is_expired.update(expired: true)
end