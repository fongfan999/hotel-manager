class Employee < ActiveRecord::Base
	has_one :account, class_name: "User"

	validates :name, presence: true
	validates :phone, presence: true, uniqueness: true

	scope :in_previous_month, -> {
  	where("created_at < ?", (Date.today - 1.month).end_of_month).count
  }

  scope :increase_in_this_month, -> {
  	current = count
  	previous = in_previous_month
  	return 100 if previous == 0
  	(((current - previous).to_f / previous)*100).round
  }

	def to_gender
		gender ? "Male" : "Female"
	end
end
