class Membership < ActiveRecord::Base

  ORGANIZATION = { :pna => 'PNA', :bcu => 'BCU' }

  belongs_to :member
  belongs_to :membership_type
  attr_accessible :expiration_date, :organization, :printed_on, :sent, :membership_type, :membership_type_id

  validates :expiration_date, :organization, :presence => false

  validates :organization, :inclusion => { :in => Membership::ORGANIZATION.values }

  def to_s
    id.to_s
  end
end
