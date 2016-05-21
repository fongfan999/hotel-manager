class Room < ActiveRecord::Base
	belongs_to :type, class_name: "RoomType"
	has_many :receipts
	has_many :customers, through: :receipts

	validates :code, :name, presence: true, uniqueness: true

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
		if customers.blank?
			"Available"
		else
			if customers.last.receipts.last.status == "Checked-out"
				"Available"
			else
				"Renting"
			end
		end
	end
end
