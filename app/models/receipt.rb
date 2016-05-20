class Receipt < ActiveRecord::Base
  belongs_to :customer
  belongs_to :room
end
