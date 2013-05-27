class FirstAidCertification < ActiveRecord::Base

  TYPE = {
    :first_aid => "First Aid",
    :cpr => "CPR"
  }

  LEVEL = {
    :four_hour => "Four Hour",
    :six_hour => "Six Hour",
    :eight_hour => "Eight Hour",
    :two_day => "Two Day",
    :other => "Other"
  }

  belongs_to :member

  attr_accessible :certification_level, :certification_type, :date, :provider, :member_id
end
