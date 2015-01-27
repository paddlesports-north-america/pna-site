class AddMembershipExpiresToMember < ActiveRecord::Migration
  def change
    add_column :members, :membership_expires, :date
    
    Member.all.each do |m|
      if m.memberships.any?
        m.membership_expires = m.memberships.last.expiration_date 
        m.save
      end
    end
  end
end
