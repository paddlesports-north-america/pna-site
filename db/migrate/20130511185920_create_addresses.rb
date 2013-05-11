class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.references :state
      t.references :country
      t.string :postal_code
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
    add_index :addresses, :state_id
    add_index :addresses, :country_id
    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
