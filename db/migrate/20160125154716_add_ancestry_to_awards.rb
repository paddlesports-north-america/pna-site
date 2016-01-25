class AddAncestryToAwards < ActiveRecord::Migration
  def up
    add_column :awards, :ancestry, :string
    add_index :awards, :ancestry
  end

  def down
    remove_index :awards, :ancestry
    remove_column :awards, :ancestry, :string
  end
end
