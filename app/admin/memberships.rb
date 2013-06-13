ActiveAdmin.register Membership do
  config.filters = false
  belongs_to :member

  form do |f|
    f.inputs do
      membership_inputs f
    end
    f.actions
  end

  sidebar 'Previous Membership', :only => :new do
    member = Member.find( params[ :member_id ] )
    unless member.memberships.empty?
      attributes_table_for member.memberships.last do
        row 'Exp' do |m| m.expiration_date end
        row 'Type' do |m| m.membership_type end
      end
    end
  end

  controller do
    def new
      @membership = Membership.new :organization => Membership::ORGANIZATION[ :pna ], :membership_type => MembershipType.find_by_name( 'Adult' )
      new!
    end
  end
end
