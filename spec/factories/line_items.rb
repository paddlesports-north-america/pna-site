# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    invoice
    description "This is a line item"
    quantity 1
    cost 1.5
  end
end
