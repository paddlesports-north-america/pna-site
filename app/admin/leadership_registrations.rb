ActiveAdmin.register LeadershipRegistration do
  belongs_to :member

  form do |f|
    f.inputs do
      f.input :award, :as => :select, :collection => Award.leadership, :input_html => { "data-hook" => "choose" }
      f.input :assessor_id, :as => :string, :input_html => member_autocomplete_options
      f.input :relevant_leadership_training, :as => :boolean
      f.input :relevant_safety_training, :as => :boolean
      f.input :first_aid, :as => :boolean
      f.input :registration_fee, :as => :boolean
    end

    f.inputs t('pna.note') do
      f.semantic_fields_for :note do |n|
        n.input :body
      end
    end

    f.actions
  end

  index do
    column :award
    column :created_at
    column :note
    default_actions
  end

  show do
    attributes_table do
      row :award
      row :member
      leadership_registration.prerequisites.each do |k,v|
        row k do v ? t('pna.yes') : t('pna.no') end
      end
      row :assessor
      row :note
    end
  end

  controller do
    def new
      @leadership_registration = LeadershipRegistration.new( { :member_id => params[ :member_id ] } )
      @leadership_registration.build_note( { :admin_user_id => current_admin_user.id } )
      new!
    end
  end
end
