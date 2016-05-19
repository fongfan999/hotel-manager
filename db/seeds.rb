# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless RoomType.exists?(name: "A")
	RoomType.create!(name: "A", cost: "150000")
end

unless RoomType.exists?(name: "B")
	RoomType.create!(name: "B", cost: "170000")
end

unless RoomType.exists?(name: "C")
	RoomType.create!(name: "C", cost: "200000")
end