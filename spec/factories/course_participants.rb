# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_participant do
    course
    member
    result CourseParticipant::RESULT.values.first
  end
end
