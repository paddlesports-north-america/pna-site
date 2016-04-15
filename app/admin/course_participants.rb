ActiveAdmin.register CourseParticipant do
  belongs_to :course

  action_item do
    link_to "Add Another Particiipant", new_admin_course_course_participant_path( Course.find( params[ :course_id ] ) )
  end

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

    f.actions
  end

  controller do
    def new
      @course_participant = CourseParticipant.new({ :course_id => params[ :course_id ] })
      @course_participant.build_note( { :admin_user_id => current_admin_user.id } )

      new!
    end

  end
end
