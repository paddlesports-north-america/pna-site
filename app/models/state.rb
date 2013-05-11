class State < ActiveRecord::Base
  belongs_to :country
  attr_accessible :abbr, :name, :country_id

  validates :abbr, :length => { :is => 2 }, :allow_blank => false
  validates :name, :country, :presence => true
end
