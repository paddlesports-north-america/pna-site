class AddProductToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :product_id, :integer
    remove_column :line_items, :description
  end
end
