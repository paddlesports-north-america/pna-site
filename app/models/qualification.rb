class Qualification < ActiveRecord::Base
  belongs_to :member
  belongs_to :award
  belongs_to :course
  attr_accessible :printed_on, :awarded_on

  validates :member, :award, :presence => true
end
