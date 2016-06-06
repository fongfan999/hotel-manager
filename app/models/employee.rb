class Employee < ActiveRecord::Base
	has_one :account, class_name: "User"

	validates :name, presence: true
	validates :phone, presence: true, uniqueness: true

	def to_gender
		gender ? "Male" : "Female"
	end
end
