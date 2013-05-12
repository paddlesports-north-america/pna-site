class CreateCourseParticipants < ActiveRecord::Migration
  def change
    create_table :course_participants do |t|
      t.references :course
      t.references :member

      t.timestamps
    end
    add_index :course_participants, :course_id
    add_index :course_participants, :member_id
  end
end
