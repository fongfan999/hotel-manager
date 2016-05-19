class CreateCustomerTypes < ActiveRecord::Migration
  def change
    create_table :customer_types do |t|
      t.string :name
      t.float :discount, default: 0

      t.timestamps null: false
    end
  end
end
