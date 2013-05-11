class Center < ActiveRecord::Base
  include HasContactInfo

  has_and_belongs_to_many :members

  has_paper_trail

  attr_accessible :name, :url

  validates :name, :url, :presence => true
end
