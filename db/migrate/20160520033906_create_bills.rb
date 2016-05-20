class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.decimal :cost, default: 0
      t.references :receipt, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
