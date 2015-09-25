class CreateRegions < ActiveRecord::Migration
  def up
    create_table :regions do |t|
      t.string :name
      t.integer :rco_id
      t.timestamps
    end
  end

  def down
  end
end
