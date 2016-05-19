class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :name
      t.decimal :cost

      t.timestamps null: false
    end
  end
end
