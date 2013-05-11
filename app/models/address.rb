class Address < ActiveRecord::Base
  has_paper_trail

  belongs_to :state
  belongs_to :country
  belongs_to :addressable, :polymorphic => true

  attr_accessible :address1, :address2, :addressable_id, :addressable_type, :city, :postal_code, :state_id, :country_id

  validates :address1, :city, :postal_code, :addressable, :country, :presence => true
  validates :state, :presence => true, :if => Proc.new { |a| !a.country.nil? && a.country.has_states? }

  validate :state_against_country, :unless => Proc.new { |a| a.state.nil? || a.country.nil? }

  private
  def state_against_country
    unless state.nil? || state.country == country
      errors.add( :state )
    end
  end

end
