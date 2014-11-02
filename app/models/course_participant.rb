class CourseParticipant < ActiveRecord::Base

  RESULT = { :pass => 'pass', :fail => 'fail', :defered => 'defered', :other => 'other' }

  belongs_to :course
  belongs_to :member

  has_one :note, :as => :noteable, :dependent => :delete
  has_one :invoice, :as => :payable

  attr_accessible :member_id, :course_id, :prerequisites_checked, :result,
                  :invoice_attributes, :note_attributes

  before_validation :set_invoice_member
  after_save :assign_qualifications

  accepts_nested_attributes_for :invoice
  accepts_nested_attributes_for :note

  validates :member, :presence => true
  validates :result, :inclusion => { :in => CourseParticipant::RESULT.values }

  def to_s
    member.to_s
  end

  private

  def set_invoice_member
    invoice.member = member unless invoice.nil?
  end

  def assign_qualifications
    if result == RESULT[:pass] && prerequisites_checked && course.program.has_award? && member.qualifications.where( :award_id => course.program.award.id ).count == 0
      member.qualifications.create( { :course_id => course.id, :award_id => course.program.award.id, :awarded_on => course.end_date || course.start_date } )
    elsif course.program.has_award? && member.qualifications.where( :award_id => course.program.award.id ).count > 0
      member.qualifications.where( :award_id => course.program.award.id ).delete_all
    end
  end
end
