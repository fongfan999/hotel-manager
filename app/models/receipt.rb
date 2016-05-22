class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room
  has_one :bill
  belongs_to :employee, class_name: "User"

  validates :quantity, presence: true,
    numericality: { greater_than_or_equal_to: 1 }

  delegate :type, to: :customer

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
end