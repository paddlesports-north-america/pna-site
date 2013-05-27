class Member < ActiveRecord::Base
  # include HasContactInfo

  has_paper_trail

  has_contact_info

  GENDER = { :male => 'm', :female => 'f' }

  has_and_belongs_to_many :centers

  has_many :qualifications, :dependent => :delete_all
  has_many :first_aid_certifications, :dependent => :delete_all
  has_many :course_participations, :class_name => 'CourseParticipant', :dependent => :delete_all
  has_many :courses, :through => :course_participations

  has_many :coached_courses, :class_name => 'CourseCoach'

  has_many :memberships, :dependent => :delete_all

  has_many :invoices, :dependent => :delete_all

  attr_accessible :bcu_number, :birthdate, :first_name, :gender, :last_name,
                  :middle_name, :addresses_attributes, :phone_numbers_attributes,
                  :email_addresses_attributes, :memberships_attributes

  accepts_nested_attributes_for :addresses, :phone_numbers, :email_addresses, :memberships

  validates :first_name, :last_name, :birthdate, :presence => true
  validates :gender, :inclusion => { :in => Member::GENDER.values }

  validate :birthdate_in_the_past

  def to_s
    "#{first_name} #{last_name}"
  end

  private
  def birthdate_in_the_past
    unless birthdate.nil? || birthdate < Date.today
      errors.add( :birthdate )
    end
  end
end
