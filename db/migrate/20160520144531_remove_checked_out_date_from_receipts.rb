class RemoveCheckedOutDateFromReceipts < ActiveRecord::Migration
  def change
    remove_column :receipts, :checked_out_date, :datetime
  end
end
