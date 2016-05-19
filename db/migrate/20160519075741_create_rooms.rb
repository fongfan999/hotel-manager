class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.string :code
      t.string :name
      t.text :annotation

      t.timestamps null: false
    end
  end
end
