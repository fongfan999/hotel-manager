class RoomType < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	has_many :rooms

	def to_label
		new_style_cost = number_with_delimiter(cost, :delimiter => ',')
		"#{name} - #{new_style_cost}"
	end

	def to_s
		name
	end
end
