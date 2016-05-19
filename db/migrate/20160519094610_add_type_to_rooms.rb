class AddTypeToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :type, index: true
    add_foreign_key :rooms, :room_types, column: :type_id
  end
end
