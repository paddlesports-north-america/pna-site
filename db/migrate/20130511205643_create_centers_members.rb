class CreateCentersMembers < ActiveRecord::Migration
  def up
    create_table :centers_members, :id => false do |t|
      t.references :center
      t.references :member
    end
    add_index :centers_members, [:center_id, :member_id]
    add_index :centers_members, [:member_id, :center_id]
  end

  def down
    drop_table :centers_members
  end
end
