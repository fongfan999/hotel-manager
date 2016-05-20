class BillService < ActiveRecord::Base
  belongs_to :service
  belongs_to :bill
end
