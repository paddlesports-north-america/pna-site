ActiveAdmin.register Invoice do
  decorate_with InvoiceDecorator
  config.batch_actions = false
  menu :priority => 3

  # filter :with_outstanding_ballance, :as => :checkbox

  form :partial => "forms/invoice"

  form decorate: false do |f|

    # f.inputs do
    #   f.input :member_id, :input_html => member_autocomplete_options
    # end

    # f.inputs do
    #   f.has_many :line_items do |l|
    #     l.input :product_id, :input_html => { "data-hook" => "choose", "data-autocomplete" => true, "data-source" => admin_products_path, "data-callback" => 'setCostField', "data-format" => "productAutocompleteFormat" }
    #     l.input :cost
    #     l.input :quantity
    #   end
    # end

    # f.inputs do
    #   f.has_many :payments do |p|
    #     p.input :source, :as => :select, :collection => Payment::SOURCE.inject({}) { |m,(k,v)| m.merge( { t("pna.payment_sources.#{k.to_s}") => v} ) }, :hint => t('pna.hints.payment.type')
    #     p.input :number, :hint => t('pna.hints.payment.number')
    #     p.input :exp_date, :hint => t('pna.hints.payment.exp_date'), :discard_day => true
    #     p.input :billing_name, :hint => t('pna.hints.payment.billing_name')
    #     p.input :amount, :hint => t('pna.hints.payment.amount')
    #   end
    # end

    invoice_inputs( f )

    f.actions
  end

  index do
    column :id
    column :member
    column :line_item_list
    column :total
    column t('pna.ballance') do |invoice|
      status_tag( invoice.ballance, invoice.status )
    end
    default_actions
  end

  show do

    columns do
      column do
        attributes_table do
          row :member
          row :total
          row :created_at
          row :has_outstanding_ballance
          row :note
        end
      end

      column do
        panel t( 'pna.payment' ).pluralize do
          unless invoice.payments.empty?
            invoice.payments.each do |p|
              attributes_table_for p do
                row :payment_source do |pi| I18n.t("pna.payment_sources.#{pi.payment_source}") end
                row :number
                row :exp_date
                row :billing_name
                row :amount
                row :note
              end
            end
          else
              para t( 'pna.no_payment' )
          end
        end
      end
    end


    panel t('pna.line_items') do
      table_for invoice.line_items do
        column :description
        column :cost
        column :quantity
        column :total
        column :note
      end
    end
  end

  controller do

    def new
      @invoice = Invoice.new
      @invoice.line_items.build
      new!
    end

  end

end
