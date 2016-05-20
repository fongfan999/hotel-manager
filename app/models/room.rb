class Room < ActiveRecord::Base
	belongs_to :type, class_name: "RoomType"
	has_many :receipts

	validates :code, :name, presence: true, uniqueness: true

	def self.available_room
		availabe_room = []
		Room.all.each do |room|
			availabe_room.push(room) if room.receipts.blank?
		end
		availabe_room.sort_by{ |room| room[:name] }
	end

	def available_room
		available_room = Room.available_room
		available_room.push(self).sort_by{ |room| room[:name] }
	end

	def check_annotation
		annotation.blank? ? "Nothing" : annotation
	end

	def to_label
		"#{name} - #{type.name}"
	end
end
