class CreateCourseCoaches < ActiveRecord::Migration
  def change
    create_table :course_coaches do |t|
      t.references :member
      t.references :course
      t.boolean :is_director, :default => false

      t.timestamps
    end
    add_index :course_coaches, :member_id
    add_index :course_coaches, :course_id
  end
end
