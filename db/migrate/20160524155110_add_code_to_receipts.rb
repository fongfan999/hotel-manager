class AddCodeToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :code, :string
  end
end
