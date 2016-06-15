class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room
  has_one :bill
  belongs_to :employee, class_name: "User"
  has_many :receipt_services
  has_many :services, through: :receipt_services

  validates :quantity, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :customer_id, :room_id, presence: true

  validate :max_quantity

  delegate :type, to: :customer

  scope :set_receipt, lambda {
    joins(:customer).where(customer_id: Customer.set_customer)
  }

  self.per_page = 10

  def max_quantity
    if quantity > room.max_quantity
      errors.add(:quantity, "is limited (#{room.max_quantity})")
    end
  end

  def to_code
  	"##{id}"
  end

  def to_tax_code
    "20071996#{self.id}"
  end

  def status
    bill.employee.nil? ? "Renting" : "Checked-out"
  end

  def employee_name
    employee.admin? ? "Admin" : employee.employee.name
  end

  def total_days
    total = ((bill.created_at - created_at) / 60 / 60 / 24).to_i
    if total <= 3
      total + 1
    else
      total
    end
  end

  def amount
    total = room.type.cost * total_days
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

  def self.search(param)
    param.strip!
    param.downcase!
     param = Customer.to_utf(param)
    (id_matches(param) + room_name_matches(param) + 
      customer_name_matches(param)).uniq
  end

  def self.id_matches(param)
    matches("receipts", "id", param)
  end

  def self.customer_name_matches(param)
    matches("customers", "utf_name", param)
  end

  def self.room_name_matches(param)
    matches("rooms", "name", param)
  end

  def self.matches(table_name, field_name, param)
    if table_name == "customers"
      results = Receipt.joins(:customer)
    else
      if table_name == "rooms"
        results = Receipt.joins(:room)
      else
        results = Receipt
      end
    end

    results.where("lower(#{table_name}.#{field_name}) LIKE ?", "%#{param}%")
  end
end
