class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name

      t.timestamps
    end
    add_index :awards, :name
  end
end
