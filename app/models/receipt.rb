class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room
  has_one :bill
  belongs_to :employee, class_name: "User"

  validates :quantity, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validate :max_quantity

  delegate :type, to: :customer

  scope :set_receipt, lambda {
    joins(:customer).where(customer_id: Customer.set_customer)
  }

  self.per_page = 10
  
  def self.search(search)
    search = search.split(//).map {|x| x[/\d+/]}.compact.join("").to_i
    where("code LIKE ?", "%#{search}%") 
  end

  def max_quantity
    if quantity > room.max_quantity
      errors.add(:quantity, "is limited (#{room.max_quantity})")
    end
  end

  def to_code
  	if id < 10
  		"RC0#{id}"
  	else
  		"RC#{id}"
  	end
  end

  def to_tax_code
    "20071996#{self.id}"
  end

  def status
    bill.employee.nil? ? "Renting" : "Checked-out"
  end

  def total_days
    total = ((bill.created_at - created_at) / 60 / 60 / 24).to_i
    if total <= 3
      total + 1
    else
      total
    end
  end

  def employee_name
    employee.admin? ? "Admin" : employee.employee.name
  end
end
