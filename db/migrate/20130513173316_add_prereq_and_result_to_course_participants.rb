class AddPrereqAndResultToCourseParticipants < ActiveRecord::Migration
  def change
    add_column :course_participants, :result, :boolean, :default => false
    add_column :course_participants, :prerequisites_checked, :boolean, :default => false
  end
end
