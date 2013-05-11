class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :centers, :name
  end
end
