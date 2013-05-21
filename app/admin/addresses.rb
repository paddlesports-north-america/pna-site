ActiveAdmin.register Address do
  menu false
  config.filters = false

  controller.belongs_to :member, :center, polymorphic: true

  form do |f|
    f.inputs do
      address_inputs f
    end
    f.actions
  end
end
