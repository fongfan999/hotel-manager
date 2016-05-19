class CustomerType < ActiveRecord::Base
	has_many :customers

	def to_label
		"#{name} - #{discount}%"
	end

	def to_s
		name
	end
end
