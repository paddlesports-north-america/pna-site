class Invoice < ActiveRecord::Base
  belongs_to :member

  has_many :line_items, :dependent => :delete_all

  attr_accessible :member_id, :line_items_attributes
  accepts_nested_attributes_for :line_items

  validates :member, :presence => true

  def total
    line_items.inject(0) { |s,l| s += l.total }
  end
end
