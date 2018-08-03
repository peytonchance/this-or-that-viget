# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |i| 
  Poll.create!(title: "Title for Poll Number#{i}", option_a: "ChoiceA#{i}", option_b: "ChoiceB#{i}", user: User.find(15), expiry_time: 1.week.from_now) 
end
