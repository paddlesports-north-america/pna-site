class FirstAidCertification < ActiveRecord::Base
  has_note

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

  # has_one :note, :as => :noteable
  # after_initialize lambda { self.note ||= Note.new }

  attr_accessible :certification_level, :certification_type, :date, :provider, :member_id #, :note
end
