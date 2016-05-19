class AddTypeToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, :type, index: true
    add_foreign_key :customers, :customer_types, column: :type_id
  end
end
