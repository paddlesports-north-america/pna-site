ActiveAdmin.register Award do
  menu :parent => 'Settings'

  config.batch_actions = false

  scope :all, :default => true

  Pna::ProgramType::ALL.each do |t|
    scope t.to_sym
  end
  
  # scope :coaching
  # scope :provider
  # scope :performance
  # scope :leadership
  # scope :endorsement
  # scope :safety
  # scope :other

  form do |f|
    f.inputs do
      f.input :name
      f.input :award_type, :as => :select, :collection => Pna::ProgramType::ALL.each.inject({}) { |m,v| m.merge({ t("pna.program_types.#{v}") => v }) }
      f.input :print_template, :as => :select, :collection => Pna::PrintTemplate::ALL
      f.input :na_number, :label => "National Accreditation number"
      f.input :parent_id, :as => :select, :collection => Award.all 
    end
    f.actions
  end
end
