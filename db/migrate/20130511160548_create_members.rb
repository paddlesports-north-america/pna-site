class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :bcu_number
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :gender
      t.date :birthdate

      t.timestamps
    end
    add_index :members, [ :bcu_number, :first_name, :last_name ]
  end
end
