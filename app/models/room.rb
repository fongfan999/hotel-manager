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

	scope :excluding_archived, -> do
  	where(archived_at: nil)
  end

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
		object.blank? ? "Vẫn chưa cập nhật." : object
	end

	def to_label
		"#{name} - #{type.name}"
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

	def archive
    self.update(archived_at: Time.now)
  end

	def self.search(param)
    param.strip!
    param.downcase!
    (room_name_matches(param) + room_type_name_matches(param) +
    	room_type_cost_matches(param) + room_annotation_matches(param) + 
    	room_max_quantity_matches(param)).uniq
  end

  def self.room_name_matches(param)
    matches("rooms", "name", param)
  end

  def self.room_type_name_matches(param)
  	matches("room_types", "name", param)
  end

  def self.room_type_cost_matches(param)
  	matches("room_types", "cost", param)
  end

  def self.room_annotation_matches(param)
  	matches("rooms", "annotation", param)
  end

  def self.room_max_quantity_matches(param)
  	matches("rooms", "max_quantity", param)
  end

  def self.matches(table_name, field_name, param)
    if field_name == "cost" || field_name == "max_quantity"
      joins(:type).where("#{table_name}.#{field_name} LIKE ?", "%#{param}%")
    else
      joins(:type).where("lower(#{table_name}.#{field_name}) LIKE ?", "%#{param}%")
      
    end
  end
end
