ActiveAdmin.register FirstAidCertification do
  belongs_to :member

  form do |f|
    f.inputs do
      f.input :provider
      f.input :date, :as => :datepicker
      f.input :certification_type, :as => :select, :collection => FirstAidCertification::TYPE.inject({}) { |m,(k,v)| m.merge( { t("pna.first_aid_types.#{k.to_s}") => v } ) }
      f.input :certification_level, :as => :select, :collection => FirstAidCertification::LEVEL.inject({}) { |m,(k,v)| m.merge( { t("pna.first_aid_levels.#{k.to_s}") => v } ) }
    end

    f.inputs t('pna.note') do
      f.semantic_fields_for :note do |n|
        n.input :body
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :certification_type
      row :certification_level
      row :provider
      row :date
      row :note
      row :created_at
      row :updated_at
    end
  end
end
