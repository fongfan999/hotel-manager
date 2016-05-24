class AddMaxQuantityToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :max_quantity, :integer, default: 1
  end
end
