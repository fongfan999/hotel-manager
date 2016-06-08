class ReceiptService < ActiveRecord::Base
  belongs_to :receipt
  belongs_to :service

  validates :quantity,
  	numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
