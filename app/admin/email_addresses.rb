ActiveAdmin.register EmailAddress do
  menu false
  config.filters = false
  controller.belongs_to :member, :center, polymorphic: true

  form do |f|
    f.inputs do
      email_address_inputs f
    end
    f.actions
  end
end
