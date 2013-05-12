class Center < ActiveRecord::Base
  has_paper_trail

  has_contact_info

  has_and_belongs_to_many :members

  attr_accessible :name, :url

  validates :name, :url, :presence => true
end
