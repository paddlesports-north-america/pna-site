class DropPayment < ActiveRecord::Migration
  def up
    drop_table :payments
  end

  def down
  end
end
