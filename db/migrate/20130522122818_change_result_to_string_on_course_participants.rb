class ChangeResultToStringOnCourseParticipants < ActiveRecord::Migration
  def up
    remove_column :course_participants, :result
    add_column :course_participants, :result, :string
  end

  def down
    remove_column :course_participants, :result
    add_column :course_participants, :result,  :boolean
  end
end
