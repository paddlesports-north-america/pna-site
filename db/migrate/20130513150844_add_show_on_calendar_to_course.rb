class AddShowOnCalendarToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :show_on_calendar, :boolean, :default => true
  end
end
