class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.boolean :gender, default: false
      t.date :date_of_birth
      t.string :phone
      t.text :address

      t.timestamps null: false
    end
  end
end
