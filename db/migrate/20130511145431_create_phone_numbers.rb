class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :label
      t.string :number
      t.string :ext
      t.integer :phoneable_id
      t.string :phoneable_type
      t.timestamps
    end
    add_index :phone_numbers, [:phoneable_id, :phoneable_type]
  end
end
