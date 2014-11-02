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
    
  end

  def phone_number_inputs(f)
    f.input :label, :hint => t('pna.hints.label')
    f.input :number
    f.input :ext
  end

  def email_address_inputs(f)
    f.input :label, :hint => t('pna.hints.label')
    f.input :address
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

  def invoice_inputs(f)
    f.inputs do
      f.input :member_id, :input_html => member_autocomplete_options
    end

    f.inputs do
      f.has_many :line_items do |l|
        line_item_inputs( l )
      end
    end

    f.inputs do
      f.has_many :payments , decorate: false do |p|
        payment_inputs( p )
      end
    end

    f.inputs t('pna.note') do
      f.semantic_fields_for :note do |n|
        n.input :body
      end
    end
  end

  def payment_inputs(f)
    f.input :payment_source, :as => :select, :collection => Payment::SOURCE.inject({}) { |m,v| m.merge( { t("pna.payment_sources.#{v}") => v} ) }, :hint => t('pna.hints.payment.type')
    f.input :number, :hint => t('pna.hints.payment.number')
    f.input :exp_date, :hint => t('pna.hints.payment.exp_date'), :discard_day => true
    f.input :billing_name, :hint => t('pna.hints.payment.billing_name')
    f.input :amount, :hint => t('pna.hints.payment.amount')

    f.input :note_body, :as => :text, :label => t('pna.note')
  end

  def line_item_inputs(f)
    f.input :product_id, :input_html => { "data-hook" => "choose", "data-autocomplete" => true, "data-source" => admin_products_path, "data-callback" => 'setCostField', "data-format" => "productAutocompleteFormat" }
    f.input :cost
    f.input :quantity

    f.input :note_body, :as => :text, :label => t('pna.note')
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
