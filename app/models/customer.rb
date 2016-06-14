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

  scope :excluding_archived, -> do
  	joins(:account).where(users: {archived_at: nil})
  end

	scope :in_previous_month, -> {
  	where("created_at < ?", (Date.today - 1.month).end_of_month).count
  }

  scope :increase_in_this_month, -> {
  	current = count
  	previous = in_previous_month
  	return 100 if previous == 0
  	(((current - previous).to_f / previous)*100).round
  }

  self.per_page = 10

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

	def self.to_utf(name)
		data = {
      'a'=>'á|à|ả|ã|ạ|ă|ắ|ặ|ằ|ẳ|ẵ|â|ấ|ầ|ẩ|ẫ|ậ|Á|À|Ả|Ã|Ạ|Ă|Ắ|Ặ|Ằ|Ẳ|Ẵ|Â|Ấ|Ầ|Ẩ|Ẫ|Ậ',
      'd'=>'đ|Đ',
      'e'=>'é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ|É|È|Ẻ|Ẽ|Ẹ|Ê|Ế|Ề|Ể|Ễ|Ệ',
      'i'=>'í|ì|ỉ|ĩ|ị|Í|Ì|Ỉ|Ĩ|Ị',
      'o'=>'ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ|Ó|Ò|Ỏ|Õ|Ọ|Ô|Ố|Ồ|Ổ|Ỗ|Ộ|Ơ|Ớ|Ờ|Ở|Ỡ|Ợ',
      'u'=>'ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự|Ú|Ù|Ủ|Ũ|Ụ|Ư|Ứ|Ừ|Ử|Ữ|Ự',
      'y'=>'ý|ỳ|ỷ|ỹ|ỵ|Ý|Ỳ|Ỷ|Ỹ|Ỵ',
		}

		new_name = name.dup

		data.each do |vowel, vietnamese|
			new_name.gsub!(/[#{vietnamese}]/, vowel)
		end

		new_name

	end

	def bills
		bills = []
		receipts.each { |receipt| bills.push(receipt.bill) }
		bills.select(&:employee_id)
	end

	def total_bills
		bills.nil? ? 0 : bills.inject(0) { |total, bill| total += bill.receipt.grand_total }
	end

	def level_up!
		if total_bills >= 30000000
			update(type_id: 5)
		else
			if total_bills >= 20000000
				update(type_id: 4)
			else
				if total_bills >= 10000000
					update(type_id: 3)
				else
					if total_bills >= 5000000
						update(type_id: 2)
					else
						update(type_id: 1)
					end
				end
			end
		end
	end

	def self.search(param)
    param.strip!
    param.downcase!
    param = Customer.to_utf(param)
    (name_matches(param) + identity_card_matches(param) +
    	phone_number_matches(param) + address_matches(param)).uniq
  end

  def self.name_matches(param)
    matches("utf_name", param)
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
