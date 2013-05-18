class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :invoice
      t.string :description
      t.integer :quantity
      t.float :cost

      t.timestamps
    end
    add_index :line_items, :invoice_id
  end
end
