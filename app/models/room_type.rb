class RoomType < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	has_many :rooms, foreign_key: "type_id"

	def self.total_amount
		RoomType.all.inject(0) do |total_amount, type|
			total_amount += type.amount
		end
	end

	def self.revenue_chart
		hash = {}
		RoomType.all.each do |type|
			tmp_hash = Hash[type.name, type.percentage]
			hash = hash.merge(tmp_hash)
		end
		hash
	end

	def to_label
		new_style_cost = number_with_delimiter(cost, :delimiter => ',')
		"#{name} - #{new_style_cost}"
	end

	def to_s
		name
	end

	def quantity
		Room.where(type: self).count
	end

	def amount
		rooms.inject(0) do |amount, room|
			amount += room.amount
		end
	end

	def percentage
		(amount / RoomType.total_amount * 100).round(1)
	end
end
