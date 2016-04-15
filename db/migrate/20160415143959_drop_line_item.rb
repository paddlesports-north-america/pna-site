class DropLineItem < ActiveRecord::Migration
  def up
    drop_table :line_items
  end

  def down

  end
end
