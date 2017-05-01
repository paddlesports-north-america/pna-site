class RemoveUnusedAwards < ActiveRecord::Migration

  def change

    # delete awards that are not reference by programs. This is more or less a mental hygiene issue although
    # awards do show up as HAS QUALIFICATIONS filter criteria on the members admin page.
    # Remove the award id from 2 Star Training. That's just wrong
    execute <<-SQL
      delete from awards where not exists (select 1 from programs where programs.award_id = awards.id);
      update programs set award_id=null where name='2 Star Training';
    SQL

    # This works on postgres which ignores NULL values WRT uniqueness
    add_index :programs, :award_id, :name => 'unique_award', :unique => true
  end
end
