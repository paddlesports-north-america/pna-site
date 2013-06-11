ActiveAdmin.register Course do
  menu :priority => 2
  config.batch_actions = false

  scope :all, :default => true
  scope :upcoming
  scope :past
  scope :calendar

  form do |f|
    f.inputs do
      f.input :program, :input_html => { "data-hook" => "choose" }
      f.input :course_provider_id,
              :as => :string, :input_html => member_autocomplete_options
      f.input :course_director_id,
              :as => :string, :input_html => member_autocomplete_options
      f.input :center, :input_html => { "data-hook" => "choose" }
      f.input :venue
      f.input :start_date, :as => :datepicker, :required => true,
              :input_html => { :class => 'start_date' }
      f.input :end_date, :as => :datepicker, :required => false,
              :input_html => { :class => 'end_date' }
      f.input :show_on_calendar
      f.input :country_id, :as => :country,
              :priority_countries => PRIORITY_COUNTRIES,
              :input_html => { 'data-type' => 'country_select' }
      f.input :state, :as => :select,
              :collection => option_groups_from_collection_for_select( Country.order(:name), :states, :name, :id, :name ),
              :input_html => { 'data-type' => 'state_select' }
      f.input :assisting_coach_ids, :as => :string,
              :label => t('pna.coach').pluralize,
              :input_html => member_autocomplete_options.merge( { :multiple => true } ),
              :hint => t('pna.hints.course.coaches')
    end

    # f.has_many :course_participants do |cp|
    #   cp.input :member, :input_html => { "data-hook" => "choose" }
    #   cp.input :result
    #   cp.input :prerequisites_checked
    # end

    f.actions
  end

  index do
    column :id
    column :program
    column :start_date
    column :end_date
    column :center
    column :course_director
    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :id
          row :program
          row :course_provider
          row :course_director
          row :center
          row :start_date
          row :end_date
          row :show_on_calendar
          row :venue
          row :country
          row :state
        end
      end

      column do
        panel t('pna.coach').pluralize do
          if course.assisting_coaches.length > 0
            table_for course.assisting_coaches do
              column t('pna.name') do |coach| link_to "#{coach.first_name} #{coach.last_name}", admin_member_path( coach ) end
              column t('pna.pna_number'), :id
              column t('pna.bcu_number'), :bcu_number
            end
          else
            para t('pna.missing.coaches')
          end
        end

        panel t('pna.student').pluralize do
          if course.course_participants.count > 0
            table_for course.course_participants do
              column t('pna.name') do |p| link_to p.member.to_s, admin_member_path( p.member ) end
              column t('pna.result') do |p| status_tag( p.result ? t('pna.pass') : t('pna.fail'), p.result ? :ok : :error ) end
            end
          else
            para t('pna.missing.students')
          end
          para link_to "#{t('pna.manage')} #{t('pna.student').pluralize}", admin_course_course_participants_path( course )
          para t('pna.hints.fee_form')
        end
      end
    end
    active_admin_comments
  end
end
