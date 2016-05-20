class Service < ActiveRecord::Base
	attr_accessor :quantity
	
	has_many :bill_services
  has_many :bills, through: :bill_services
	validates :unit, :price, presence: true
	validates :name, presence: true, uniqueness: true

	def get_quantity(bill)
		bill_services = BillService.find_by(service_id: self.id, bill_id: bill.id)
		if bill_services
			bill_services.quantity
		else
			0
		end
	end
end
