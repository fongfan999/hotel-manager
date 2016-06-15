class Service < ActiveRecord::Base
	attr_accessor :quantity
	
	has_many :receipt_services
  has_many :receipts, through: :receipt_services
	validates :unit, :price, presence: true
	validates :name, presence: true, uniqueness: true

	scope :excluding_archived, -> do
  	where(archived_at: nil)
  end

	scope :in_previous_week, -> {
  	where("created_at < ?", (Date.today - 1.week).end_of_week).count
  }

  scope :increase_in_this_week, -> {
  	current = count
  	previous = in_previous_week
  	return 100 if previous == 0
  	(((current - previous).to_f / previous)*100).round
  }

	self.per_page = 10

	def get_quantity(receipt)
		receipt_services = ReceiptService.find_by(service: self, receipt: receipt)
		if receipt_services
			receipt_services.quantity
		else
			0
		end
	end

	def archive
    self.update(archived_at: Time.now)
  end

  def self.search(param)
    param.strip!
    param.downcase!
    (name_matches(param) + unit_matches(param) + 
      price_matches(param)).uniq
  end

  def self.name_matches(param)
    matches("name", param)
  end

  def self.unit_matches(param)
    matches("unit", param)
  end

  def self.price_matches(param)
    matches("price", param)
  end

  def self.matches(field_name, param)
	where("lower(#{field_name}) LIKE ?", "%#{param}%")
  end
end
