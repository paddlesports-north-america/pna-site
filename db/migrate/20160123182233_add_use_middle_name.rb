class AddUseMiddleName < ActiveRecord::Migration
  def change
    add_column :members, :use_middle_name, :boolean, :default => false
  end
end
