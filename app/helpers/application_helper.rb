module ApplicationHelper
	def title(*parts)
		unless parts.empty?
			content_for :title do
				(parts << "Palace Hotel").join(" - ")
			end
		end
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
	end

	def format_money(money)
		number_with_delimiter(money, delimiter: ',')
	end
end
