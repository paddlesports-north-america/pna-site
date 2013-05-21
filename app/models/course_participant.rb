class CourseParticipant < ActiveRecord::Base
  belongs_to :course
  belongs_to :member

  has_one :invoice, :as => :payable

  attr_accessible :member_id, :course_id, :prerequisites_checked, :result, :invoice_attributes

  before_validation :set_invoice_member
  after_create :assign_qualifications

  accepts_nested_attributes_for :invoice
  validates :member, :presence => true

  private

  def set_invoice_member
    invoice.member = member unless invoice.nil?
  end

  def assign_qualifications
    if result && prerequisites_checked && course.program.has_award?
      member.qualifications.create( { :course_id => course.id, :award_id => course.program.award.id } )
    end
  end
end
