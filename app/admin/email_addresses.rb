ActiveAdmin.register EmailAddress do
  menu false
  config.filters = false
  controller do
    belongs_to :member, polymorphic: true
    belongs_to :center, polymorphic: true
  end

  form do |f|
    f.inputs do
      email_address_inputs f
    end
    f.actions
  end
end
