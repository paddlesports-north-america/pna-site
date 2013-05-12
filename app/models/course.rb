class Course < ActiveRecord::Base
  has_paper_trail

  has_region

  belongs_to :program
  belongs_to :course_provider, :class_name => 'Member'
  belongs_to :center
  attr_accessible :date, :venue

  validates :program, :course_provider, :date, :presence => true
end
