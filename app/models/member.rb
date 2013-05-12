class Member < ActiveRecord::Base
  # include HasContactInfo

  has_paper_trail

  has_contact_info

  GENDER = { :male => 'm', :female => 'f' }

  has_and_belongs_to_many :centers

  has_many :qualifications

  attr_accessible :bcu_number, :birthdate, :first_name, :gender, :last_name, :middle_name

  validates :first_name, :last_name, :birthdate, :presence => true
  validates :gender, :inclusion => { :in => Member::GENDER.values }

  validate :birthdate_in_the_past

  private
  def birthdate_in_the_past
    unless birthdate.nil? || birthdate < Date.today
      errors.add( :birthdate )
    end
  end
end
