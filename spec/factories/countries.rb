# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    name "United States"
    iso3 "USA"
    iso "US"
    iso_name "UNITED STATES"
    numcode "840"

    factory :country_with_states do
      after(:create) do |country|
        FactoryGirl.create( :state, country: country )
      end
    end
  end
end
