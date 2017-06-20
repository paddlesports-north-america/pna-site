class AddCoursesNullConstraints < ActiveRecord::Migration
  def up
    change_column :courses, :course_provider_id, :integer, :null => false
    change_column :courses, :program_id, :integer, :null => false
  end

  def down
    change_column :courses, :course_provider_id, :integer, :null => true
    change_column :courses, :program_id, :integer, :null => true
  end
end
