class Service < ActiveRecord::Base
	attr_accessor :quantity
	
	has_many :receipt_services
  has_many :receipts, through: :receipt_services
	validates :unit, :price, presence: true
	validates :name, presence: true, uniqueness: true

	scope :in_previous_month, -> {
  	where("created_at < ?", (Date.today - 1.month).end_of_month).count
  }

  scope :increase_in_this_month, -> {
  	current = count
  	previous = in_previous_month
  	return 100 if previous == 0
  	(((current - previous).to_f / previous)*100).round
  }

	self.per_page = 10

	def get_quantity(receipt)
		receipt_services = ReceiptService.find_by(service: self, receipt: receipt)
		if receipt_services
			receipt_services.quantity
		else
			0
		end
	end
end
