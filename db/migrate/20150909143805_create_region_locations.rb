class CreateRegionLocations < ActiveRecord::Migration
  def change
    create_table :region_locations do |t|
      t.references :region
      t.references :location, :polymorphic => true, :index => true
      t.timestamps
    end
    add_index :region_locations, :region_id
  end
end
