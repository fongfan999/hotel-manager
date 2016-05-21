class AddEmployeeToReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :employee, index: true
    add_foreign_key :receipts, :users, column: :employee_id
  end
end
