class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :room, index: true, foreign_key: true
      t.integer :quantity, default: 1
      t.datetime :check_out_date

      t.timestamps null: false
    end
  end
end
