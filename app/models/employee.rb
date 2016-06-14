class Employee < ActiveRecord::Base
	has_one :account, class_name: "User"

	validates :name, presence: true
	validates :phone, presence: true, uniqueness: true
  validates :address, presence: true, length: { minimum: 5, maximum: 50 }

  scope :excluding_archived, -> do
    joins(:account).where(users: {archived_at: nil})
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

	def to_gender
		gender ? "Nam" : "Nữ"
	end
end
