class CreateReceiptServices < ActiveRecord::Migration
  def change
    create_table :receipt_services do |t|
      t.references :receipt, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true
      t.integer :quantity, default: 0
    end
  end
end
