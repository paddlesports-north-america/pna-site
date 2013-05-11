class EmailAddress < ActiveRecord::Base
  has_paper_trail

  belongs_to :emailable, :polymorphic => true
  attr_accessible :address, :emailable_id, :emailable_type, :label

  validates :emailable, :presence => true
  validates :address, :email => true, :presence => true
end
