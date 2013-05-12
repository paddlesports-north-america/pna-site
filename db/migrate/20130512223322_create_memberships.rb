class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.date :expiration_date
      t.string :organization
      t.references :member
      t.date :printed_on
      t.boolean :sent, :default => false

      t.timestamps
    end
    add_index :memberships, :member_id
  end
end
