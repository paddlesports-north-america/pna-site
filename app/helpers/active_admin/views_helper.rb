module ActiveAdmin::ViewsHelper

  def member_autocomplete_options
    { "data-hook" => "choose", "data-autocomplete" => true, "data-source" => admin_members_path, "data-format" => "memberAutocompleteFormat" }
  end

  def address_inputs(f)
    f.input :address1
    f.input :address2
    f.input :city
    f.input :postal_code
    unless @address.nil?
      f.input :country_id, :as => :country, :object => @address, :method => 'country_id', :priority_countries => PRIORITY_COUNTRIES, :input_html => { 'data-type' => 'country_select' }
      f.input :state, :as => :select, :collection => option_groups_from_collection_for_select( Country.order(:name), :states, :name, :id, :name, @address.state_id ), :input_html => { 'data-type' => 'state_select' }
    else
      f.input :country_id, :as => :country, :priority_countries => PRIORITY_COUNTRIES, :input_html => { 'data-type' => 'country_select' }
      f.input :state, :as => :select, :collection => option_groups_from_collection_for_select( Country.order(:name), :states, :name, :id, :name ), :input_html => { 'data-type' => 'state_select' }
    end
    f.input :public
  end

  def phone_number_inputs(f)
    f.input :label, :hint => t('pna.hints.label')
    f.input :number
    f.input :ext
    f.input :public
  end

  def email_address_inputs(f)
    f.input :label, :hint => t('pna.hints.label')
    f.input :address
    f.input :public
  end

  def membership_inputs(f)
    f.input :organization, :as => :select, :collection => Membership::ORGANIZATION, :include_blank => false
    f.input :membership_type, :include_blank => false
    f.input :expiration_date, :as => :datepicker, :input_html => { 'data-years' => "c-1:c+5" }
    f.input :printed_on, :as => :datepicker, :input_html => { 'data-years' => "c-1:c+5" }
    f.input :sent
  end

  def note_inputs(f)
    f.semantic_fields_for :note do |n|
      n.input :body
    end
  end

  def manage_txt(obj)
    "#{obj}"
  end

  def result_status_tag_status( result )
    if result == CourseParticipant::RESULT[ :pass ]
      status = :ok
    elsif result == CourseParticipant::RESULT[ :fail ]
      status = :error
    else
      status = :warning
    end

    status
  end

end
