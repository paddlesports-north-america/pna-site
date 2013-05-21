class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :source
      t.string :number
      t.date :exp_date
      t.float :amount
      t.string :billing_name
      t.references :invoice

      t.timestamps
    end
    add_index :payments, :invoice_id
  end
end
