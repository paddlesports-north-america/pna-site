# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    program nil
    member nil
    type ""
    prerequisites "MyText"
    assessor_id 1
    trainer_id 1
  end
end
