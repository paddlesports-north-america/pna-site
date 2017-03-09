class EraseUkccText < ActiveRecord::Migration
  def change
    execute <<-SQL
      update awards set name=regexp_replace(name, '^UKCC ', '');
      update programs set name=regexp_replace(name, '^UKCC ', '');
    SQL
  end
end
