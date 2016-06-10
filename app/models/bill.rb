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

  def self.chart_by_week(cols)
    hash = {}
    results = Bill.order(created_at: :desc).group_by { |b| b.created_at.beginning_of_week }

    results.each do |key, value|
      tmp = {}
      end_of_week = key.end_of_week
      tmp["#{key.strftime('%d/%m')} - #{end_of_week.strftime('%d/%m')}"] = value.count
      hash.merge!(tmp)
    end

    hash.to_a.reverse.first(cols).to_h
  end

  def employee_name
    employee.admin? ? "Admin" : employee.employee.name
  end

  def self.search(param)
    receipts = Receipt.search(param)

    bills = []
    receipts.each do |receipt|
      bills.push(receipt.bill) unless receipt.bill.employee.nil?
    end

    bills
  end
end
