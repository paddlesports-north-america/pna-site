ActiveAdmin.register Address do
  menu false
  config.filters = false

  belongs_to :member, polymorphic: true
  # belongs_to :center, polymorphic: true

  form do |f|
    f.inputs do
      address_inputs f
    end
    f.actions
  end
end
