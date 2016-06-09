class AddUtfNameToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :utf_name, :string
  end
end
