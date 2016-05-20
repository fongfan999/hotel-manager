class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room
  has_one :bill

  def to_code
  	if id < 10
  		"RC0#{id}"
  	else
  		"RC#{id}"
  	end
  end

  def status
  	"Renting"
  end
end
