ActiveAdmin.register Center do
  menu :parent => 'Settings'

  decorate_with CenterDecorator

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :member_tokens, :as => :string, 
        :label => 'Associated Members',
        :input_html => member_autocomplete_options.merge( { :multiple => true } )
    end

    f.inputs do
      f.has_many :phone_numbers do |p|
        phone_number_inputs p
      end
    end

    f.inputs do
      f.has_many :email_addresses do |e|
        email_address_inputs e
      end
    end

    f.inputs do
      f.has_many :addresses do |a|
        address_inputs a
      end
    end

    f.actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :url
          row :email_address
          row :phone_number
          row :created_at
        end
      end

      column do
        panel t('pna.member').pluralize do
          unless center.members.empty?
            table_for center.members do
              column t('pna.name') do |m| link_to "#{m.first_name} #{m.last_name}", admin_member_path( m ) end
            end
          else
            para t('pna.no_members')
          end
        end
      end
    end
  end

end
