# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    program
    date "2013-10-11"
    country
    venue "Someplace Awesome"
    course_provider factory: :member
    center

    after(:build) do |a|
      if !a.country.nil? && a.country.has_states?
        a.state = a.country.states.first
      end
    end

    factory :course_with_coach do
      after( :create ) do |c|
        c.coaches = [ FactoryGirl.create( :member_with_contact_info ) ]
        c.save
      end

      factory :course_with_director do
        after( :create ) do |c|
          c.course_director = FactoryGirl.create( :member_with_centers )
          c.save
        end
      end
    end
  end
end
