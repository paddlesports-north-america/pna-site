class CourseCoach < ActiveRecord::Base
  belongs_to :member
  belongs_to :course
  attr_accessible :member_id, :member, :is_director

  validates :member, :course, :presence => true

  def to_s
    "#{member.first_name} #{member.last_name}"
  end

end
