ActiveAdmin.register Course do

  form do |f|
    f.inputs do
      f.input :program, :input_html => { "data-hook" => "choose" }
      f.input :course_provider, :input_html => { "data-hook" => "choose" }
      f.input :center, :input_html => { "data-hook" => "choose" }
      f.input :venue
      f.input :date, :as => :datepicker
      f.input :country_id, :as => :country, :priority_countries => PRIORITY_COUNTRIES, :input_html => { 'data-type' => 'country_select' }
      f.input :state, :as => :select, :collection => option_groups_from_collection_for_select( Country.order(:name), :states, :name, :id, :name ), :input_html => { 'data-type' => 'state_select' }
    end
    f.actions
  end
end
