ActiveAdmin.register Member do

  decorate_with MemberDecorator

  menu :priority => 1

  form do |f|
    f.inputs do
      f.input :bcu_number
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :gender, :as => :select, :collection => Member::GENDER.inject({}) { |m,(k,v)| m.merge( t( "genders.#{k.to_s}" ) => v ) }
      f.input :birthdate, :as => :date_picker, :input_html => { "data-years" => "c-100:c+0" }
    end
    f.actions
  end

  show do

    columns do
      column do

        attributes_table do
          row :id
          row :bcu_number
          row :first_name
          row :middle_name
          row :last_name
          row :gender
          row :birthdate
        end

        panel t('pna.phone_number').pluralize do
          table_for member.phone_numbers do
            column :label
            column :number
            column :ext
          end

          para link_to "#{t('pna.manage')} #{t('pna.phone_number').pluralize}", admin_member_phone_numbers_path( member )
        end

        panel t('pna.email_address').pluralize do
          table_for member.email_addresses do
            column :label
            column :address
          end

          para link_to "#{t('pna.manage')} #{t('pna.email_address').pluralize}", admin_member_email_addresses_path( member )
        end

        panel t('pna.mailing_address').pluralize do
          table_for member.addresses do
            column :address1
            column :address2
            column :city
            column :state
            column :postal_code
            column :country
          end

          para link_to "#{t('pna.manage')} #{t('pna.mailing_address').pluralize}", admin_member_addresses_path( member )
        end
      end

      column do

        panel t('pna.qualification').pluralize do
          if member.qualifications.empty?
            para t('pna.member_has_no_qualifications')
          else
            table_for member.qualifications do
              column t('pna.qualification') do |q| link_to q.award.name, admin_member_qualification_path( member, q ) end
              column t('pna.completed') do |q| q.awarded_on end
              column t('pna.printed') do |q| q.printed_on.nil? ? status_tag( t('pna.not_printed'), :error ) : status_tag( q.printed_on.to_s, :ok ) end
            end
          end
          para link_to "#{t('pna.manage')} #{t('pna.qualification').pluralize}", admin_member_qualifications_path( member )
        end

        unless member.courses.empty?
          panel t('pna.training_history') do
            table_for member.course_participations do
              column t('pna.course') do |c| link_to c.course.program.name, admin_course_path( c.course ) end
              column t('pna.course_director') do |c| link_to c.course.course_director, admin_member_path( c.course.course_director ) end
              column t('pna.date') do |c| c.course.date end
              column t('pna.result') do |c| status_tag( c.result ? t('pna.pass') : t('pna.fail'), c.result ? :ok : :error ) end
            end
          end
        end

        unless member.coached_courses.empty?
          panel t('pna.coaching_history') do
            table_for member.coached_courses do
              column t('pna.course') do |c| link_to c.course.program.name, admin_course_path( c.course ) end
              column t('pna.course_director') do |c| link_to c.course.course_director, admin_member_path( c.course.course_director ) end
              column t('pna.date') do |c| c.course.date end
            end
          end
        end

      end
    end

  end

end
