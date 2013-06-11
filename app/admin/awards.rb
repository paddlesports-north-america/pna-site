ActiveAdmin.register Award do

  config.batch_actions = false

  scope :all, :default => true
  scope :coaching
  scope :safety
  scope :leadership
  scope :other

  form do |f|
    f.inputs do
      f.input :name
      f.input :award_type, :as => :select, :collection => Pna::ProgramType::ALL.each.inject({}) { |m,v| m.merge({ t("pna.program_types.#{v}") => v }) }
    end
    f.actions
  end
end
