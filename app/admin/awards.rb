ActiveAdmin.register Award do
  menu :parent => 'Settings'

  config.batch_actions = false

  scope :all, :default => true
  scope :coaching
  scope :performance
  scope :leadership
  scope :endorsement
  scope :safety
  scope :other

  form do |f|
    f.inputs do
      f.input :name
      f.input :award_type, :as => :select, :collection => Pna::ProgramType::ALL.each.inject({}) { |m,v| m.merge({ t("pna.program_types.#{v}") => v }) }
      f.input :na_number, :label => "National Accreditation number"
    end
    f.actions
  end
end
