class DropBillServices < ActiveRecord::Migration
  def change
  	drop_table :bill_services
  end
end
