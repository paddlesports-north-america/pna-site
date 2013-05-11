# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :center do
    name "Body Boat Blade, International"
    url "http://www.bodyboatblade.com"

    factory :center_with_phone_numbers do
      after(:create) do |center|
        FactoryGirl.create( :phone_number, phoneable: center )
      end
    end

    factory :center_with_email_addresses do
      after(:create) do |center|
        FactoryGirl.create( :email_address, emailable: center )
      end
    end

    factory :center_with_addresses do
      after(:create) do |center|
        FactoryGirl.create( :address, addressable: center )
      end
    end

    factory :center_with_contact_info do
      after(:create) do |center|
        FactoryGirl.create( :phone_number, phoneable: center )
        FactoryGirl.create( :email_address, emailable: center )
        FactoryGirl.create( :address, addressable: center )
      end
    end
  end

  factory :center_with_members, parent: :center_with_contact_info do
    after( :create ) do |center|
      FactoryGirl.create( :member_with_contact_info, centers: [center] )
    end
  end
end
