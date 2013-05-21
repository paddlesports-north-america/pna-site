class Center < ActiveRecord::Base
  has_paper_trail

  has_contact_info

  has_and_belongs_to_many :members

  attr_accessible :name, :url, :email_addresses_attributes, :phone_numbers_attributes,
                  :addresses_attributes, :member_ids

  accepts_nested_attributes_for :email_addresses, :phone_numbers, :addresses

  validates :name, :url, :presence => true
end
