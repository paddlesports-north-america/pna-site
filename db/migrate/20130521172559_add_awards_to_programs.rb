class AddAwardsToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :award_id, :integer
  end
end
