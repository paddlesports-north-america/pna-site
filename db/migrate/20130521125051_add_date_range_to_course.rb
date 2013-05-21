class AddDateRangeToCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :date
    add_column :courses, :start_date, :date
    add_column :courses, :end_date, :date
  end
end
