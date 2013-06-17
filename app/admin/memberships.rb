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

  action_item :only => :show do
    link_to 'Print', admin_member_membership_print_path( params[ :member_id ], params[ :id ] )
  end

  controller do
    def new
      @membership = Membership.new :organization => Membership::ORGANIZATION[ :pna ], :membership_type => MembershipType.find_by_name( 'Adult' )
      new!
    end

    def print
      output = MembershipPdf.new( :page_size => MembershipPdf::PAGE_SIZE, :margin_left => MembershipPdf::MARGIN, :margin_right => MembershipPdf::MARGIN, :margin_top => 0, :margin_bottom => 0 ).to_pdf( Membership.find( params[ :membership_id ] ) )
      send_data output, :filename => "membership-#{params[:member_id]}", :type => "application/pdf", :disposition => "inline"
    end
  end
end
