class CourseParticipant < ActiveRecord::Base

  RESULT = { :pass => 'pass', :fail => 'fail', :defered => 'defered', :other => 'other' }

  belongs_to :course
  belongs_to :member

  has_one :note, :as => :noteable, :dependent => :delete

  attr_accessible :member_id, :course_id, :prerequisites_checked, :result, :note_attributes

  # Ok this is terrible as are all callbacks. I (RRK) would remove it but we're using the ActiveAdmin stuff and
  # this is probably the easiest way to handle the creation of quals.
  after_save :assign_qualifications

  accepts_nested_attributes_for :note

  validates :member, :course, :presence => true
  validates :result, :inclusion => { :in => CourseParticipant::RESULT.values }

  def to_s
    member.to_s
  end

  def assign_qualifications
    if should_award_qualificiation
      awarded_date = course.end_date || course.start_date
      qual = member.qualifications.where( :award_id => course.program.award.id ).first
      if qual.nil?
        member.qualifications.create( { :course_id => course.id, :award_id => course.program.award.id, :first_awarded_on => awarded_date, :most_recent_award => awarded_date } )
      else
        qual.course_id = course.id
        qual.most_recent_award = awarded_date
        qual.save
      end
    end
  end

  def should_award_qualificiation
    result == RESULT[:pass] && prerequisites_checked and course.program.has_award?
  end

end
