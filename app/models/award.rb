class Award < ActiveRecord::Base
  attr_accessible :name, :award_type

  validates :name, :presence => true

  scope :coaching, where( :award_type => Pna::ProgramType::COACHING )
  scope :performance, where( :award_type => Pna::ProgramType::PERFORMANCE )
  scope :leadership, where( :award_type => Pna::ProgramType::LEADERSHIP )
  scope :safety, where( :award_type => Pna::ProgramType::SAFETY )
  scope :other, where( :award_type => Pna::ProgramType::OTHER )
end
