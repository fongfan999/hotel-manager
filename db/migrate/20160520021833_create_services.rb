class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :unit
      t.decimal :price, default: 0

      t.timestamps null: false
    end
  end
end
