class AddMembershipTypeIdToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :membership_type_id, :integer
  end
end
