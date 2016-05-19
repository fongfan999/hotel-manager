class Customer < ActiveRecord::Base
	belongs_to :type, class_name: "CustomerType"

	validates :name, presence: true
	validates :identity_card, presence: true,
		length: { minimum: 9, maximum: 15 }

	def check_address
		address.blank? ? "Nothing" : address
	end
end
