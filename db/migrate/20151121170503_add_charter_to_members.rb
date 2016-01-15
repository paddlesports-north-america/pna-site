class AddCharterToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :is_charter_member, :boolean, :default => false
    
    limit = Date.new(2016)
    
    Member.all.each do |m|
      if m.memberships.any? && m.memberships.first.created_at < limit
        m.update_attribute( :is_charter_member, true )
      end
    end
  end
  
  def self.down
    remove_column :members, :is_charter_member
  end
end
