class CreateBillServices < ActiveRecord::Migration
  def change
    create_table :bill_services do |t|
      t.integer :quantity, default: 0
      t.references :service, index: true, foreign_key: true
      t.references :bill, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
