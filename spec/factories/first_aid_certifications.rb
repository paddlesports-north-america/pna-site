# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :first_aid_certification do
    provider "MyString"
    date "2013-05-23"
    certification_type "MyString"
    certification_level "MyString"
    member nil
  end
end
