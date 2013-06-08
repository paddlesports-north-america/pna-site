ActiveAdmin.register CoachingRegistration do
  belongs_to :member

  form do |f|
    f.inputs do
      f.input :program_id, :as => :select, :collection => Program.coaching, :input_html => { "data-hook" => "choose" }
      f.input :assessor_id, :as => :string, :input_html => member_autocomplete_options
      f.input :trainer_id, :as => :string, :input_html => member_autocomplete_options
      f.input :relevant_star_award, :as => :boolean
      f.input :relevant_safety_training, :as => :boolean
      f.input :first_aid, :as => :boolean
      f.input :pre_req_coaching_award, :as => :boolean
    end

    f.inputs t('pna.note') do
      # note_inputs f
      f.semantic_fields_for :note do |n|
        n.input :body
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :program
      row :member
      row :prerequisites
      row :assessor
      row :trainer
      row :note
    end
  end

  controller do
    def new
      @coaching_registration = CoachingRegistration.new( { :member_id => params[ :member_id ] } )
      @coaching_registration.build_note( { :admin_user_id => current_admin_user.id } )
      new!
    end
  end
end
