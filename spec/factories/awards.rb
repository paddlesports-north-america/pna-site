# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :award do
    name "Test Award"
    print_template Pna::PrintTemplate::ALL.first
  end
end
