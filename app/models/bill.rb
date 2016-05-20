class Bill < ActiveRecord::Base
  belongs_to :receipt
  has_many :bill_services
  has_many :services, through: :bill_services
end
