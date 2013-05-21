# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    source "credit"
    number "1234"
    exp_date "2015-05-01"
    amount 1.5
    billing_name "John Doe"
    invoice
  end
end
