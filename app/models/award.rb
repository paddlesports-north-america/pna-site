class Award < ActiveRecord::Base
  attr_accessible :name, :award_type

  validates :name, :presence => true

  scope :coaching, where( :award_type => Pna::ProgramType::COACHING )
  scope :performance, where( :award_type => Pna::ProgramType::PERFORMANCE )
  scope :leadership, where( :id => Program.leadership.pluck( :award_id ) )
  scope :safety, where( :award_type => Pna::ProgramType::SAFETY )
  scope :endorsement, where( :award_type => Pna::ProgramType::ENDORSEMENT )
  scope :other, where( :award_type => Pna::ProgramType::OTHER )
end
