class Invoice < ActiveRecord::Base
  belongs_to :member
  belongs_to :payable, :polymorphic => true

  has_many :payments, :dependent => :delete_all
  has_many :line_items, :dependent => :delete_all

  attr_accessible :member_id, :line_items_attributes, :payments_attributes
  accepts_nested_attributes_for :line_items
  accepts_nested_attributes_for :payments

  validates :member, :presence => true

  def total
    line_items.inject(0) { |s,l| s += l.total }
  end

  def to_s
    id
  end
end
