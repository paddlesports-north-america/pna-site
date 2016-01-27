class Award < ActiveRecord::Base
  attr_accessible :name, :award_type, :na_number, :print_template, :parent_id

  validates :print_template, :inclusion => { :in => Pna::PrintTemplate::ALL.push( "" ) }
  validates :name, :presence => true

  has_award_scope
  has_ancestry
  
end
