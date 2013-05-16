ActiveAdmin.register PhoneNumber do
  menu false
  config.filters = false
  controller.belongs_to :member, :center, polymorphic: true

  form do |f|
    f.inputs do
      f.input :label
      f.input :number
      f.input :ext
    end
    f.actions
  end
end
