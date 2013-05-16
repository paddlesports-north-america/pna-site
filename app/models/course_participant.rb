class CourseParticipant < ActiveRecord::Base
  belongs_to :course
  belongs_to :member
  attr_accessible :member_id, :course_id, :prerequisites_checked, :result

  validates :course, :member, :presence => true
end
