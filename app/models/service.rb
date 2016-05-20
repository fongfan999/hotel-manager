class Service < ActiveRecord::Base
	has_many :bill_services
  has_many :bills, through: :bill_services
	validates :unit, :price, presence: true
	validates :name, presence: true, uniqueness: true
end
