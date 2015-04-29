ActiveAdmin.register Qualification do
  belongs_to :member
  menu false
  config.filters = false

  form do |f|
    f.inputs do
      f.input :award, :input_html => { "data-hook" => "choose" }
      f.input :course, :input_html => { "data-hook" => "choose" }
      f.input :awarded_on, :as => :date_picker
      f.input :printed_on, :as => :date_picker
      f.input :verified, :hint => "A qualification should be verified only if you have seen supporting evidence, ie. appropriate paperwork"
    end
    f.actions
  end

  action_item :only => :show do
    link_to 'Print', admin_member_qualification_print_path( params[ :member_id ], params[ :id ] ), :target => "_blank"
  end

  controller do

    def print
      member = Member.find( params[ :member_id ] )

      qualification = Qualification.find( params[ :qualification_id ] )
      qualification.printed_on = Date.today
      qualification.save

      award = qualification.award

      args = {
        :award => award.name,
        :member => member,
        :date => qualification.awarded_on,
        :course => qualification.course
      }

      clazz = "#{award.award_type.humanize}Pdf".constantize

      output = clazz.new( :page_size => clazz::PAGE_SIZE, :margin => clazz::MARGIN ).to_pdf( args )
      send_data output, :filename => "#{member.id}-#{qualification.id}.pdf", :type => "application/pdf", :disposition => "inline"
    end

  end
end
