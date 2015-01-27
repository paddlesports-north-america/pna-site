ActiveAdmin.register Member do

  decorate_with MemberDecorator

  menu :priority => 1

  # preserve_default_filters!
  filter :id, :label => 'PNA Number'
  filter :bcu_number
  filter :first_name
  filter :last_name
  
  filter :addresses_state, as: :select, collection: proc { State.all }, label: 'State or Province'
  filter :addresses_country, as: :select, collection: proc { Country.order( 'name asc') }, label: 'Country'

  filter :qualifications_id, as: :select, :multiple => true, collection: proc { Award.order( "name asc" ) }

  controller do
    def autocomplete
      respond_with Member.where( "lower( concat( first_name, ' ', last_name ) ) like ? OR cast( id as text ) like ?", "%#{params[ :q ].downcase}%", "%#{params[ :q ].downcase}%" ), :location => nil
    end
    
    # def scoped_collection
    #   super.includes :memberships
    # end
  end

  index do |m|
    selectable_column
    column t('pna.pna_number'), :id
    column :bcu_number
    column :first_name
    column :last_name
    column t('pna.exp_date'), sortable: :membership_expires do |m| status_tag( m.expiration_date.to_s, m.membership_status ) end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :bcu_number
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :gender, :as => :select, :collection => Member::GENDER.inject({}) { |m,(k,v)| m.merge( t( "genders.#{k.to_s}" ) => v ) }
      f.input :birthdate, :as => :date_picker, :input_html => { "data-years" => "c-100:c+0" }, :hint => 'YYYY-MM-DD'
    end

    if member.new_record?

      f.inputs do
        f.has_many :memberships do |m|
          membership_inputs m
        end
      end

      f.inputs do
        f.has_many :addresses do |a|
          address_inputs a
        end
      end

      f.inputs do
        f.has_many :phone_numbers do |p|
          phone_number_inputs p
        end
      end

      f.inputs do
        f.has_many :email_addresses do |e|
          email_address_inputs e
        end
      end

    end

    f.inputs t('pna.note') do
      f.semantic_fields_for :note do |n|
        n.input :body
      end
    end

    f.actions
  end

  sidebar :options, :only => :show do
    ul do
      li link_to manage_txt( t('pna.membership' ).pluralize ), admin_member_memberships_path( member )
      li link_to manage_txt( t('pna.phone_number').pluralize ), admin_member_phone_numbers_path( member )
      li link_to manage_txt( t('pna.email_address').pluralize ), admin_member_email_addresses_path( member )
      li link_to manage_txt( t('pna.mailing_address').pluralize ), admin_member_addresses_path( member )
      li link_to manage_txt( t('pna.qualification').pluralize ), admin_member_qualifications_path( member )
      li link_to manage_txt( t('pna.first_aid_certification').pluralize ), admin_member_first_aid_certifications_path( member )
      li link_to manage_txt( t('pna.coaching_registration').pluralize ), admin_member_coaching_registrations_path( member )
      li link_to manage_txt( t('pna.leadership_registration').pluralize ), admin_member_leadership_registrations_path( member )
    end
  end

  show do

    columns do
      column do

        attributes_table do
          row t('pna.pna_number') do |m| m.id end
          row :bcu_number
          row t('pna.exp_date') do |m| status_tag( m.expiration_date.to_s, m.membership_status ) end
          row :first_name
          row :middle_name
          row :last_name
          row :gender
          row :birthdate
          row :note
        end

        panel t('pna.phone_number').pluralize do
          if member.phone_numbers.count > 0
            table_for member.phone_numbers do
              column :label
              column :number
              column :ext
            end

            para link_to "#{t('pna.manage')} #{t('pna.phone_number').pluralize}", admin_member_phone_numbers_path( member )
          else
            para "#{t('pna.member_has_no') % t('pna.phone_number').pluralize}"
            para link_to t('pna.create'), new_admin_member_phone_number_path( member )
          end
        end

        panel t('pna.email_address').pluralize do
          if member.email_addresses.count > 0
            table_for member.email_addresses do
              column :label
              column :address
            end
            para link_to "#{t('pna.manage')} #{t('pna.email_address').pluralize}", admin_member_email_addresses_path( member )
          else
            para "#{t('pna.member_has_no') % t('pna.email_address').pluralize}"
            para link_to t('pna.create'), new_admin_member_email_address_path( member )
          end
        end

        panel t('pna.mailing_address').pluralize do
          if member.addresses.count > 0
            table_for member.addresses do
              column :address1
              column :address2
              column :city
              column :state
              column :postal_code
              column :country
            end

            para link_to "#{t('pna.manage')} #{t('pna.mailing_address').pluralize}", admin_member_addresses_path( member )
          else
            para "#{t('pna.member_has_no') % t('pna.mailing_address').pluralize}"
            para link_to t('pna.create'), new_admin_member_address_path( member )
          end
        end
      end

      column do

        panel t('pna.first_aid_certification').pluralize do
          if member.first_aid_certifications.empty?
            para "#{t('pna.member_has_no') % t('pna.first_aid_certification').pluralize}"
            para link_to t('pna.create'), new_admin_member_first_aid_certification_path( member )
          else
            table_for member.first_aid_certifications do
              column :certification_type
              column :certification_level
              column :provider
              column :expiration_date
            end
            para link_to "#{t('pna.manage')} #{t('pna.first_aid_certification').pluralize}", admin_member_first_aid_certifications_path( member )
          end
        end

        panel t('pna.qualification').pluralize do
          if member.qualifications.empty?
            para "#{t('pna.member_has_no') % t('pna.qualification').pluralize}"
            para link_to t('pna.create'), new_admin_member_qualification_path( member )
          else
            table_for member.qualifications do
              column t('pna.qualification') do |q| link_to q.award.name, admin_member_qualification_path( member, q ) end
              column t('pna.completed') do |q| q.awarded_on end
              column t('pna.printed') do |q| q.printed_on.nil? ? status_tag( t('pna.not_printed'), :error ) : status_tag( q.printed_on.to_s, :ok ) end
            end
            para link_to "#{t('pna.manage')} #{t('pna.qualification').pluralize}", admin_member_qualifications_path( member )
          end
        end

        unless member.courses.empty?
          panel t('pna.training_history') do
            table_for member.course_participations do
              column t('pna.course') do |c| link_to c.course.program.name, admin_course_path( c.course ) end
              column t('pna.course_director') do |c| link_to c.course.course_director, admin_member_path( c.course.course_director ) end
              column t('pna.date') do |c| c.course.start_date end
              column t( 'pna.result' ) do |p| status_tag( p.result, result_status_tag_status( p.result ) ) end
            end
          end
        end

        unless member.coached_courses.empty?
          panel t('pna.coaching_history') do
            table_for member.coached_courses do
              column t('pna.course') do |c| link_to c.course.program.name, admin_course_path( c.course ) end
              column t('pna.course_director') do |c| link_to c.course.course_director, admin_member_path( c.course.course_director ) end
              column t('pna.date') do |c| c.course.start_date end
            end
          end
        end

        unless member.leadership_registrations.empty? && member.coaching_registrations.empty?
          panel t('pna.registration' ).pluralize do
            table_for Registration.where( :member_id => member.id ) do
              column :award
              column :created_at
            end
          end
        end

      end
    end

  end

end
