class Customer < ActiveRecord::Base
	belongs_to :type, class_name: "CustomerType"
	has_many :receipts
	has_many :rooms, through: :receipts
	has_one :account, class_name: "User"

	validates :name, presence: true
	validates :identity_card, presence: true,
		length: { minimum: 9, maximum: 15 }, uniqueness: true

	scope :set_customer, lambda {
	  joins(:account).where( users: {id: User.current_user.id})
  }

	def self.available_customer
		available_customer = []
		Customer.all.each do |customer|
			if customer.receipts.blank?
				available_customer.push(customer)
			else
				if customer.receipts.last.status == "Checked-out"
					available_customer.push(customer)
				end
			end
		end
		available_customer.sort_by{ |customer| customer[:name] }
	end

	def available_customer
		available_customer = Customer.available_customer
		available_customer.push(self).sort_by{ |customer| customer[:name] }
	end

	def check_blank(object)
		object.blank? ? "not yet been updated." : object
	end

	def to_label
		"#{name} - #{type.name}"
	end

	def self.search(param)
    param.strip!
    param.downcase!
    (name_matches(param) + identity_card_matches(param) +
    	phone_number_matches(param) + address_matches(param)).uniq
  end

  def self.name_matches(param)
    matches("name", param)
  end

  def self.identity_card_matches(param)
    matches("identity_card", param)
  end

  def self.phone_number_matches(param)
    matches("phone_number", param)
  end

  def self.address_matches(param)
  	matches("address", param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end
end
