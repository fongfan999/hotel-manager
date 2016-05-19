class Room < ActiveRecord::Base
	belongs_to :type, class_name: "RoomType"

	validates :code, :name, presence: true, uniqueness: true
	# validates :cost, presence: true

	def check_annotation
		annotation.blank? ? "Nothing" : annotation
	end
end
