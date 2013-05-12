ActiveAdmin.register Member do

  form do |f|
    f.inputs do
      f.input :bcu_number
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :gender, :as => :select, :collection => Member::GENDER.inject({}) { |m,(k,v)| m.merge( t( "genders.#{k.to_s}" ) => v ) }
      f.input :birthdate, :as => :date_picker, :input_html => { "data-years" => "c-100:c+0" }
    end
    f.actions
  end

end
