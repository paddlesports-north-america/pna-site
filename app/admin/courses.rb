ActiveAdmin.register Course do

  config.batch_actions = false

  scope :all, :default => true
  scope :upcoming
  scope :past
  scope :calendar

  form do |f|
    f.inputs do
      f.input :program, :input_html => { "data-hook" => "choose" }
      f.input :course_provider, :input_html => { "data-hook" => "choose" }
      f.input :course_director_id, :as => :select, :input_html => { "data-hook" => "choose" }, :collection => Member.order( :last_name )
      f.input :center, :input_html => { "data-hook" => "choose" }
      f.input :venue
      f.input :date, :as => :datepicker
      f.input :show_on_calendar
      f.input :country_id, :as => :country, :priority_countries => PRIORITY_COUNTRIES, :input_html => { 'data-type' => 'country_select' }
      f.input :state, :as => :select, :collection => option_groups_from_collection_for_select( Country.order(:name), :states, :name, :id, :name ), :input_html => { 'data-type' => 'state_select' }
      f.input :assisting_coach_ids, :as => :select, :collection => Member.order( :last_name ), :label => t('pna.coach').pluralize, :input_html => { :multiple => true, "data-hook" => "choose" }
    end

    unless course.new_record?
      f.has_many :course_participants do |cp|
        cp.input :member, :input_html => { "data-hook" => "choose" }
        cp.input :result
        cp.input :prerequisites_checked
      end
    end

    f.actions
  end

  index do
    column :id
    column :program
    column :date
    column :course_provider
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
          row :date
          row :show_on_calendar
          row :venue
          row :country
          row :state
        end
      end

      column do
        panel t('pna.coach').pluralize do
          table_for course.assisting_coaches do
            column t('pna.name') do |coach| link_to "#{coach.first_name} #{coach.last_name}", admin_member_path( coach ) end
            column t('pna.pna_number'), :id
            column t('pna.bcu_number'), :bcu_number
          end
        end

        panel t('pna.student').pluralize do
          table_for course.course_participants do
            column t('pna.name') do |p| link_to p.member.to_s, admin_member_path( p.member ) end
            column t('pna.result') do |p| status_tag( p.result ? t('pna.pass') : t('pna.fail'), p.result ? :ok : :error ) end
          end
        end
      end
    end
    active_admin_comments
  end
end
