ActiveAdmin.register CourseParticipant do
  belongs_to :course

  index do
    selectable_column
    column :member
    column :result
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :member, :input_html => { "data-hook" => "choose" }
      f.input :result
      f.input :prerequisites_checked
    end

    f.inputs "Invoice" do
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
      desc = "#{Course.find(params[:course_id]).program.name}: Course # #{params[:course_id]}"
      @course_participant.invoice.line_items.build( { :description => desc })
      @course_participant.invoice.payments.build
      new!
    end

  end
end
