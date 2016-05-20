class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room

  def to_code
  	"RC00#{id}"
  end
end
