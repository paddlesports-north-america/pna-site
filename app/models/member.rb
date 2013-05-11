class Member < ActiveRecord::Base
  has_paper_trail

  GENDER = { :male => 'm', :female => 'f' }

  has_many :phone_numbers,
    :as => :phoneable,
    :dependent => :delete_all,
    :validate => true

  has_many :email_addresses,
    :as => :emailable,
    :dependent => :delete_all,
    :validate => true

  has_many :addresses,
    :as => :addressable,
    :dependent => :delete_all,
    :validate => true

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
