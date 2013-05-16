ActiveAdmin.register Qualification do
  belongs_to :member
  menu false
  config.filters = false

  form do |f|
    f.inputs do
      f.input :award, :input_html => { "data-hook" => "choose" }
      f.input :course, :input_html => { "data-hook" => "choose" }
      f.input :awarded_on, :as => :date_picker
      f.input :printed_on, :as => :date_picker
    end
    f.actions
  end
end
