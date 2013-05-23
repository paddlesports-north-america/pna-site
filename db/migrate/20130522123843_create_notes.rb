class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :body
      t.integer :noteable_id
      t.string :noteable_type
      t.references :admin_user

      t.timestamps
    end
    add_index :notes, [ :noteable_type, :noteable_id ]
    add_index :notes, :admin_user_id
  end
end
