# Simple migration to change the nullabilities of the joined records ids

class UpdateQualNullabilities < ActiveRecord::Migration
  def up
    change_column :qualifications, :member_id, :integer, :null => false
    change_column :qualifications, :award_id, :integer, :null => false
  end

  def down
    change_column :qualifications, :member_id, :integer, :null => true
    change_column :qualifications, :award_id, :integer, :null => true
  end
end
