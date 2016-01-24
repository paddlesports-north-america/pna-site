class Program < ActiveRecord::Base

  belongs_to :award

  attr_accessible :name, :award_id, :program_type, :award_attributes
  accepts_nested_attributes_for :award

  validates :name, :presence => true
  validates :program_type, :inclusion => { :in => Pna::ProgramType::ALL }

  has_award_scope  
  # scope :coaching, where( :program_type => Pna::ProgramType::COACHING )
  # scope :performance, where( :program_type => Pna::ProgramType::PERFORMANCE )
  # scope :leadership, where( :program_type => Pna::ProgramType::LEADERSHIP )
  # scope :safety, where( :program_type => Pna::ProgramType::SAFETY )
  # scope :other, where( :program_type => Pna::ProgramType::OTHER )

  def has_award?
    !award.nil?
  end
end
