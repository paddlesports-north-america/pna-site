class AddContactToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :contact, :string
  end
end
