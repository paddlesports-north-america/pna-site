class Country < ActiveRecord::Base

  has_many :states
  
  has_one :region_location, :as => :location
  has_one :region, through: :region_location

  attr_accessible :iso, :iso3, :iso_name, :name, :numcode

  validates :iso, :iso3, :iso_name, :name, :numcode, :presence => true

  validates :iso, :length => { :is => 2 }, :allow_blank => false
  validates :iso3, :length => { :is => 3 }, :allow_blank => false

  def has_states?
    State.exists?( :country_id => id )
  end
end
