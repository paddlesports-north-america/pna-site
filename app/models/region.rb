class Region < ActiveRecord::Base
  attr_accessible :name, :rco_id, :contact
  belongs_to :rco, :class_name => :Member, :foreign_key => :rco_id
  
  has_many :region_locations, :dependent => :destroy
  
  def locations
    region_locations.collect { |rl| rl.location }
  end
  
  def add_location( location )
    region_locations.create( :location => location );
  end
end
