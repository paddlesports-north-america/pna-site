# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :qualification do
    member
    award
    printed_on "2013-05-12"
    awarded_on "2013-05-12"
    course
  end
end
