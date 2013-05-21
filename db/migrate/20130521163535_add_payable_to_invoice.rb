class AddPayableToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :payable_type, :string
    add_column :invoices, :payable_id, :integer
  end
end
