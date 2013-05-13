ActiveAdmin.register Address do
  menu false
  controller.belongs_to :member, :center, polymorphic: true

  form do |f|
    f.inputs do
      f.input :address1
      f.input :address2
      f.input :city
      f.input :postal_code
      f.input :country_id, :as => :country, :priority_countries => PRIORITY_COUNTRIES, :input_html => { 'data-type' => 'country_select' }
      f.input :state, :as => :select, :collection => option_groups_from_collection_for_select( Country.order(:name), :states, :name, :id, :name ), :input_html => { 'data-type' => 'state_select' }
    end
    f.actions
  end
end
