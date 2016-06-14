class RoomType < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	has_many :rooms, foreign_key: "type_id"

	validates :name, :cost, presence: true

	scope :total_amount, -> (start_date, end_date) do
    total_amount = RoomType.all.inject(0) do |total_amount, type|
			total_amount += type.amount(start_date, end_date)
		end
  end

  scope :total_days, -> (start_date, end_date) do
    total_days = RoomType.all.inject(0) do |total_days, type|
			total_days += type.total_days(start_date, end_date)
		end
  end

  scope :revenue_chart, -> (start_date, end_date) do
    hash = {}
		RoomType.all.each do |type|
			tmp_hash = Hash[type.name, type.amount(start_date, end_date)]
			hash = hash.merge(tmp_hash)
		end
		hash
  end

  scope :day_chart, -> (start_date, end_date) do
    hash = {}
		RoomType.all.each do |type|
			tmp_hash = Hash[type.name, type.total_days(start_date, end_date)]
			hash = hash.merge(tmp_hash)
		end
		hash
  end

	def to_label
		new_style_cost = number_with_delimiter(cost, :delimiter => ',') + " VNĐ"
		"#{name} - #{new_style_cost}"
	end

	def to_s
		name
	end

	def quantity
		Room.where(type: self).count
	end

	def amount(start_date, end_date)
		rooms.inject(0) do |amount, room|
			amount += room.amount(start_date, end_date)
		end
	end

	def percentage_revenues(start_date, end_date)
		return 0 if RoomType.total_amount(start_date, end_date) == 0
		(amount(start_date, end_date).to_f / RoomType.total_amount(start_date,
			end_date) * 100).round(1) 
	end

	def total_days(start_date, end_date)
		rooms.inject(0) do |total_days, room|
			total_days += room.total_days(start_date, end_date)
		end
	end

	def percentage_days(start_date, end_date)
		return 0 if RoomType.total_days(start_date, end_date) == 0
		(total_days(start_date, end_date).to_f / RoomType.total_days(start_date,
			end_date) * 100).round(1) 
	end
end
