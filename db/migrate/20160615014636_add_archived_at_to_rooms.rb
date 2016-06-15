class AddArchivedAtToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :archived_at, :date
  end
end
