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


unless Room.exists?(name: "101")
	Room.create!(name: "101", type: RoomType.first)
end

unless Room.exists?(name: "102")
	Room.create!(name: "102", type: RoomType.first)
end

unless Room.exists?(name: "103")
	Room.create!(name: "103", type: RoomType.first)
end

unless Room.exists?(name: "201")
	Room.create!(name: "201", type: RoomType.second)
end

unless Room.exists?(name: "202")
	Room.create!(name: "202", type: RoomType.second)
end

unless Room.exists?(name: "301")
	Room.create!(name: "301", type: RoomType.third)
end


unless CustomerType.exists?(name: "Newbie")
	CustomerType.create!(name: "Newbie", discount: 0)
end

unless CustomerType.exists?(name: "Basic")
	CustomerType.create!(name: "Basic", discount: 2)
end

unless CustomerType.exists?(name: "Standard")
	CustomerType.create!(name: "Standard", discount: 5)
end

unless CustomerType.exists?(name: "Loyal")
	CustomerType.create!(name: "Loyal", discount: 8)
end

unless CustomerType.exists?(name: "VIP")
	CustomerType.create!(name: "VIP", discount: 10)
end

unless Service.exists?(name: "Dr. Thanh")
	Service.create!(name: "Dr. Thanh", unit: "bottle", price: "20000")
end

unless Service.exists?(name: "CocaCola")
	Service.create!(name: "CocaCola", unit: "bottle", price: "15000")
end

unless Service.exists?(name: "Pepsi")
	Service.create!(name: "Pepsi", unit: "bottle", price: "16000")
end

unless Service.exists?(name: "SevenUp")
	Service.create!(name: "SevenUp", unit: "bottle", price: "14000")
end

unless Service.exists?(name: "Sprite")
	Service.create!(name: "Sprite", unit: "bottle", price: "14000")
end

unless Service.exists?(name: "Lavie")
	Service.create!(name: "Lavie", unit: "bottle", price: "10000")
end

unless Service.exists?(name: "Aquafina")
	Service.create!(name: "Aquafina", unit: "bottle", price: "10000")
end

unless Service.exists?(name: "Vinh Hao")
	Service.create!(name: "Vinh Hao", unit: "bottle", price: "10000")
end


unless User.exists?(email: "admin@example.com")
	User.create!(email: "admin@example.com", password: "password",
		admin: true
	)
end
