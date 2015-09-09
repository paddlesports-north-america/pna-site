class State < ActiveRecord::Base
  belongs_to :country
  
  has_one :region_location, :as => :location
  has_one :region, through: :region_location
  
  attr_accessible :abbr, :name, :country_id

  validates :abbr, :length => { :is => 2 }, :allow_blank => false
  validates :name, :country, :presence => true

  default_scope order( 'name asc' )
end
