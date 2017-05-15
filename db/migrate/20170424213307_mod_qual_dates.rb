# This is a wide ranging migration focused on fixing issues with qualification handling. In particular
# the current schema allows nulls in the awarded_on column and there is no notion of when a member first
# achieved a qual. It includes a data cleanup (removing null values from awarded_on).
class ModQualDates < ActiveRecord::Migration
  def up
    # This is obviously not reversible and of course must be executed first
    Qualification.where('awarded_on is null').update_all("awarded_on = now() - interval '18 months'")

    add_column :qualifications, :most_recent_award, :date
    rename_column :qualifications, :awarded_on, :first_awarded_on
    Qualification.update_all("most_recent_award = first_awarded_on")

    change_column :qualifications, :first_awarded_on, :date, :null => false
    change_column :qualifications, :most_recent_award, :date, :null => false
  end

  def down
    remove_column :qualifications,:most_recent_award
    rename_column :qualifications,:first_awarded_on,:awarded_on
    change_column :qualifications, :awarded_on, :date, :null => true
  end
end
