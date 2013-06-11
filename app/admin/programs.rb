ActiveAdmin.register Program do
  menu :parent => 'Settings'

  config.batch_actions = false

  scope :all, :default => true
  scope :coaching
  scope :safety
  scope :leadership
  scope :other

  form do |f|
    f.inputs do
      f.input :name
      f.input :program_type, :as => :select, :collection => Pna::ProgramType::ALL.inject({}) { |m,v| m.merge( { t("pna.program_types.#{v}") => v } ) }
      f.input :award, :input_html => {"data-hook" => "choose"}
    end
    f.actions
  end

end
