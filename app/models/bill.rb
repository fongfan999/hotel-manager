class Bill < ActiveRecord::Base
  belongs_to :receipt
  belongs_to :employee, class_name: "User"

  delegate :customer, to: :receipt
  delegate :room, to: :receipt

  scope :fill_date, -> (start_date, end_date) do
    where(['bills.created_at >= ?', start_date.beginning_of_day])
    .where(['bills.created_at <= ?', end_date.end_of_day])
  end

  scope :persisted, -> { where("employee_id is NOT NULL") }

  self.per_page = 10

  def employee_name
    employee.admin? ? "Admin" : employee.employee.name
  end
end
