class AddArchivedAtToServices < ActiveRecord::Migration
  def change
    add_column :services, :archived_at, :date
  end
end
