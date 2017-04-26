# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    award
    name "A Test Program"
    program_type Pna::ProgramType::ALL.first
  end
end
