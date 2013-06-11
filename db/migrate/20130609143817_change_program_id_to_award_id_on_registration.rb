class ChangeProgramIdToAwardIdOnRegistration < ActiveRecord::Migration
  def up
    remove_column :registrations, :program_id
    add_column :registrations, :award_id, :integer
    add_index :registrations, :award_id
  end

  def down
  end
end
