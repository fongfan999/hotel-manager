class RemoveCodeFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :code, :string
  end
end
