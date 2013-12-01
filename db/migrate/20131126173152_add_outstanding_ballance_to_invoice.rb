class AddOutstandingBallanceToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :has_outstanding_ballance, :boolean, default: true
  end
end
