# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :qualification do
    member
    award
    printed_on "2013-05-12"
    first_awarded_on "2013-05-12"
    most_recent_award "2013-05-12"
    course
  end
end
