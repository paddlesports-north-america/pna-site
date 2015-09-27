class CoachPageMods < ActiveRecord::Migration
  def up
    add_column :members, :show_on_coaches_page, :boolean, :default => false
    add_column :email_addresses, :public, :boolean, :default => false
    add_column :phone_numbers, :public, :boolean, :default => false
    add_column :addresses, :public, :boolean, :default => false
  end

  def down
    remove_column :members, :show_on_coaches_page
    remove_column :email_addresses, :public
    remove_column :phone_numbers, :public
    remove_column :addresses, :public
  end
end
