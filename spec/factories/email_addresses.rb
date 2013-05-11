# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email_address do
    address "super@tester.new"
    label "Test"
    emailable factory: :member
  end
end
