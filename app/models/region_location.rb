class RegionLocation < ActiveRecord::Base
  attr_accessible :region, :location
  belongs_to :region
  belongs_to :location, :polymorphic => true
end
