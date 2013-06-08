class Program < ActiveRecord::Base

  PROGRAM_TYPES = { :other => "other", :leadership => "leadership", :coaching => "coaching", :performance => "performance", :safety => "safety" }

  belongs_to :award

  attr_accessible :name, :award_id, :program_type, :award_attributes
  accepts_nested_attributes_for :award

  validates :name, :presence => true

  scope :coaching, where( :program_type => Program::PROGRAM_TYPES[ :coaching ] )
  scope :performance, where( :program_type => Program::PROGRAM_TYPES[ :performance ] )
  scope :leadership, where( :program_type => Program::PROGRAM_TYPES[ :leadership ] )
  scope :other, where( :program_type => Program::PROGRAM_TYPES[ :other ] )

  def has_award?
    !award.nil?
  end
end
