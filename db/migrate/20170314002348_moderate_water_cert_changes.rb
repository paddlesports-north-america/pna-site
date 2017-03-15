class ModerateWaterCertChanges < ActiveRecord::Migration
  def change
    # Change the print template for everything that is an endorsement to an attendance and strip Endorsement from the
    # end of the mod water endorsements so they make more sense when printed and change those print templates to endorsement
    execute <<-SQL
      update awards set print_template='attendance' where print_template='endorsement';
      update awards set name=replace(name, 'Endorsement', ''), print_template='endorsement' where name like 'Moderate Water %';
    SQL
  end
end
