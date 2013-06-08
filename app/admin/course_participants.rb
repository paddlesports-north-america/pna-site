ActiveAdmin.register CourseParticipant do
  belongs_to :course

  index do
    selectable_column
    column :member
    column :result
    default_actions
  end

  show do
    attributes_table do
      row :course
      row :member
      row :result
      row :prerequisites_checked
      row :note
    end
  end

  form do |f|
    f.inputs do
      f.input :member_id, :as => :string, :input_html => member_autocomplete_options
      f.input :result, :as => :select, :collection => CourseParticipant::RESULT.inject({}) { |m,(k,v)| m.merge( { t("pna.course_results.#{v}" ) => v } ) }
      f.input :prerequisites_checked
    end

    f.inputs t('pna.note') do
      note_inputs f
    end

    f.inputs t('pna.invoice'), "data-hook" => 'optional' do
      f.semantic_fields_for :invoice do |i|
        i.has_many :line_items do |l|
          line_item_inputs l
        end

        i.has_many :payments do |p|
          payment_inputs p
        end
      end
    end

    f.actions
  end

  controller do
    def new
      @course_participant = CourseParticipant.new({ :course_id => params[ :course_id ] })
      @course_participant.build_invoice
      @course_participant.build_note( { :admin_user_id => current_admin_user.id } )
      # @course_participant.invoice.line_items.build()
      # @course_participant.invoice.payments.build
      new!
    end

  end
end
