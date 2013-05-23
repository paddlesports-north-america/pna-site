# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    body "MyText"
    noteable_id 1
    noteable_type "MyString"
    admin_user_id 1
  end
end
