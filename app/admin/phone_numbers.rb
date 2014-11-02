ActiveAdmin.register PhoneNumber do
  menu false
  config.filters = false
  # controller.belongs_to :member, :center, polymorphic: true

  form do |f|
    f.inputs do
      phone_number_inputs f
    end
    f.actions
  end
end
