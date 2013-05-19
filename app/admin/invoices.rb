ActiveAdmin.register Invoice do
  decorate_with InvoiceDecorator
  config.batch_actions = false

  form do |f|
    f.inputs do
      f.input :member, :input_html => { "data-hook" => "choose" }
    end

    f.has_many :line_items do |l|
      l.input :description
      l.input :cost
      l.input :quantity
    end

    f.actions
  end

  index do
    column :id
    column :member
    column :line_item_list
    column :total
    default_actions
  end

  show do
    attributes_table do
      row :member
      row :total
      row :created_at
    end

    panel t('pna.line_items') do
      table_for invoice.line_items do
        column :description
        column :cost
        column :quantity
        column :total
      end
    end
  end

end
