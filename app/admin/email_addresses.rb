ActiveAdmin.register EmailAddress do
  menu false
  controller.belongs_to :member, :center, polymorphic: true

  form do |f|
    f.inputs do
      f.input :label
      f.input :address
    end
    f.actions
  end
end
