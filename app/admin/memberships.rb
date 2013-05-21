ActiveAdmin.register Membership do
  belongs_to :member

  form do |f|
    f.inputs do
      membership_inputs f
    end
    f.actions
  end
end
