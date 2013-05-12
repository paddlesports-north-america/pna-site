class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.references :member
      t.references :award
      t.date :printed_on
      t.date :awarded_on
      t.references :course

      t.timestamps
    end
    add_index :qualifications, :member_id
    add_index :qualifications, :award_id
    add_index :qualifications, :course_id
  end
end
