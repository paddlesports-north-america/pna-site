class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references :program
      t.references :member
      t.string :type
      t.text :prerequisites
      t.integer :assessor_id
      t.integer :trainer_id

      t.timestamps
    end
    add_index :registrations, :program_id
    add_index :registrations, :member_id
  end
end
