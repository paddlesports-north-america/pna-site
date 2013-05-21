ActiveAdmin.register Program do

  form do |f|
    f.inputs do
      f.input :name
      f.input :program_type, :as => :select, :collection => Program::PROGRAM_TYPES.inject({}) { |m,(k,v)| m.merge( { t("pna.program_types.#{v}") => v } ) }
      f.input :award, :input_html => {"data-hook" => "choose"}
    end
    f.actions
  end

end
