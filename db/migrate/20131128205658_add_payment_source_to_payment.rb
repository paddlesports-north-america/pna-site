class AddPaymentSourceToPayment < ActiveRecord::Migration
  def change
    rename_column :payments, :source, :payment_source
  end
end
