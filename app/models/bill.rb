class Bill < ActiveRecord::Base
  belongs_to :receipt
  has_many :bill_services
  has_many :services, through: :bill_services

  delegate :customer, to: :receipt
  delegate :room, to: :receipt

  def total_cost
  	total = receipt.room.type.cost * receipt.total_days
  	services.each do |service|
  		total += service.price * service.get_quantity(self)
  	end
  	total
  end
end
