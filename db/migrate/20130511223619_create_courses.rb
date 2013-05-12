class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :program
      t.date :date
      t.references :country
      t.references :state
      t.string :venue
      t.references :course_provider
      t.references :center

      t.timestamps
    end
    add_index :courses, :program_id
    add_index :courses, :country_id
    add_index :courses, :state_id
    add_index :courses, :course_provider_id
    add_index :courses, :center_id
  end
end
