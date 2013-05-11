# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address1 "123 Fun St"
    address2 "APT. 2B"
    city "Funtown"
    country
    postal_code "98245"
    addressable factory: :member

    after(:build) do |a|
      if a.country.has_states?
        a.state = a.country.states.first
      end
    end
  end
end
