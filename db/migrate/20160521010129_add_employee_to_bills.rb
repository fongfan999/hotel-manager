class AddEmployeeToBills < ActiveRecord::Migration
  def change
    add_reference :bills, :employee, index: true
    add_foreign_key :bills, :users, column: :employee_id
  end
end
