class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :identity_card
      t.text :address

      t.timestamps null: false
    end
  end
end
