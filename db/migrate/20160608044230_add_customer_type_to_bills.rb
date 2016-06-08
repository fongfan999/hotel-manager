class AddCustomerTypeToBills < ActiveRecord::Migration
  def change
    add_column :bills, :customer_type, :integer
    remove_column :receipts, :code, :integer
  end
end
