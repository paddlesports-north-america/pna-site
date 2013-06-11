class AddAwardTypeToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :award_type, :string
  end
end
