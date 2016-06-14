class Room < ActiveRecord::Base
	belongs_to :type, class_name: "RoomType"
	has_many :receipts
	has_many :bills, through: :receipts
	has_many :customers, through: :receipts

	validates :name, presence: true, uniqueness: true
	validates :max_quantity, presence: true,
		numericality: {	only_integer: true, greater_than_or_equal_to: 1,
			less_than_or_equal_to: 6 }
	validates :type_id, presence: true

	scope :in_previous_week, -> {
  	where("created_at < ?", (Date.today - 1.week).end_of_week).count
  }

  scope :increase_in_this_week, -> {
  	current = count
  	previous = in_previous_week
  	return 100 if previous == 0
  	(((current - previous).to_f / previous)*100).round
  }
  
	def self.available_room
		availabe_room = []
		Room.all.each do |room|
			if room.receipts.blank?
				availabe_room.push(room)
			else
				if room.receipts.last.status == "Checked-out"
					availabe_room.push(room)
				end
			end
		end
		availabe_room.sort_by{ |room| room[:name] }
	end

	def available_room
		available_room = Room.available_room
		available_room.push(self).sort_by{ |room| room[:name] }
	end

	def check_blank(object)
		object.blank? ? "Not yet been updated." : object
	end

	def to_label
		"#{name} - #{type.name}"
	end

	def to_code
		"R#{self.name}"
	end

	def status
		if receipts.blank? || receipts.last.status == "Checked-out"
			"Available"
		else
			"Renting"
		end
	end

	def amount(start_date, end_date)
		bills.fill_date(start_date, end_date).inject(0) { |amount, bill|
			amount += bill.receipt.grand_total unless bill.employee.nil?
		}.to_i
	end

	def total_days(start_date, end_date)
		bills.fill_date(start_date, end_date).inject(0) { |total_days, bill|
			total_days += bill.receipt.total_days unless bill.employee.nil?
		}.to_i
	end
end
