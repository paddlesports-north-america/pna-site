# A Qualification is achieved as the result of getting a "pass" when taking a course AND having the qualifications
# prerequisites completed at the time the course was completed.
#
# The logic for creating these automatically is contained in the CourseParticipant class
#

class Qualification < ActiveRecord::Base

  belongs_to :member
  belongs_to :award
  belongs_to :course
  attr_accessible :printed_on, :first_awarded_on, :award_id, :member_id, :course_id, :verified, :most_recent_award

  validates :member, :award, :presence => true
  
  delegate :award_type, to: :award
end
