class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room
  has_one :bill

  def to_code
  	"RC00#{id}"
  end
end
