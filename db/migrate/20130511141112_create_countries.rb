class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso3
      t.string :iso
      t.string :iso_name
      t.string :numcode

      t.timestamps
    end
  end
end
