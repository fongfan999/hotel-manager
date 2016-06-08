class Service < ActiveRecord::Base
	attr_accessor :quantity
	
	has_many :receipt_services
  has_many :receipts, through: :receipt_services
	validates :unit, :price, presence: true
	validates :name, presence: true, uniqueness: true

	def get_quantity(receipt)
		receipt_services = ReceiptService.find_by(service: self, receipt: receipt)
		if receipt_services
			receipt_services.quantity
		else
			0
		end
	end
end
