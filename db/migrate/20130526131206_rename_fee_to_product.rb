class RenameFeeToProduct < ActiveRecord::Migration
  def change
    rename_table :fees, :products
  end
end
