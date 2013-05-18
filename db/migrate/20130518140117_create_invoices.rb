class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :member

      t.timestamps
    end
    add_index :invoices, :member_id
  end
end
