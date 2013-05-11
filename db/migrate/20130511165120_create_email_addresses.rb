class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.string :address
      t.string :label
      t.integer :emailable_id
      t.string :emailable_type

      t.timestamps
    end
    add_index :email_addresses, [ :emailable_id, :emailable_type ]
  end
end
