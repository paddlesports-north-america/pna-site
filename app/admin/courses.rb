ActiveAdmin.register Course do

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
    end
    f.actions
  end

  show do
    attributes_table do
      row :id, :label => "Course Number"
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
    active_admin_comments
  end
end
