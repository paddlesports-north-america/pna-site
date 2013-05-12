class CourseCoach < ActiveRecord::Base
  belongs_to :member
  belongs_to :course
  attr_accessible :member_id, :member, :is_director

  validates :member, :course, :presence => true
end
