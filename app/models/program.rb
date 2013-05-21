class Program < ActiveRecord::Base

  PROGRAM_TYPES = { :other => "other", :leadership => "leadership", :coaching => "coaching", :performance => "performance", :safety => "safety" }

  attr_accessible :name, :award_id, :program_type
  belongs_to :award
  validates :name, :presence => true

  def has_award?
    !award.nil?
  end
end
