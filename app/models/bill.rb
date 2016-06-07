class Bill < ActiveRecord::Base
  belongs_to :receipt
  has_many :bill_services
  has_many :services, through: :bill_services
  belongs_to :employee, class_name: "User"

  delegate :customer, to: :receipt
  delegate :room, to: :receipt

  scope :fill_date, -> (start_date, end_date) do
    where(['bills.created_at >= ?', start_date.beginning_of_day])
    .where(['bills.created_at <= ?', end_date.end_of_day])
  end

  # Customer's availalble Bill 
  scope :available_bill, lambda {
    joins(:receipt).merge(Receipt.set_receipt)
  }

  scope :persisted, -> { where("employee_id is NOT NULL") }

  self.per_page = 10
  
  def amount
  	total = receipt.room.type.cost * receipt.total_days
  	services.each do |service|
  		total += service.price * service.get_quantity(self)
  	end
  	total
  end

  def discount
    customer.type.discount
  end

  def grand_total
    (amount) + (amount / 10) - (amount * discount / 100)
  end

  def employee_name
    employee.admin? ? "Admin" : employee.employee.name
  end
end
