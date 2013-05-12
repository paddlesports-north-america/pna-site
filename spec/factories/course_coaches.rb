# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_coach do
    member factory: :member
    course factory: :course
    is_director false

    factory :course_director do
      is_director true
    end
  end
end
