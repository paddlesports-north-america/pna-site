# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fee do
    description "MyString"
    amount 1.5
    category "MyString"
  end
end
