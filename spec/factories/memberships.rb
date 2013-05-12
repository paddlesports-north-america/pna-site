# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    expiration_date "2014-05-12"
    organization "BCU"
    member
    printed_on "2013-05-12"
    sent "2013-05-12"
  end
end
