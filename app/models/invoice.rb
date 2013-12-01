class Invoice < ActiveRecord::Base
  has_note
  has_note_attribute

  belongs_to :member
  belongs_to :payable, :polymorphic => true

  has_many :payments, :dependent => :delete_all
  has_many :line_items, :dependent => :delete_all

  attr_accessible :member_id, :line_items_attributes, :payments_attributes, :has_outstanding_ballance
  accepts_nested_attributes_for :line_items
  accepts_nested_attributes_for :payments

  validates :member, :presence => true

  before_save :check_ballance

  def total
    line_items.inject(0) { |s,l| s += l.total }
  end

  def total_payments
    payments.inject( 0.0 ) { |s,p| s += p.amount }
  end

  def ballance
    total - total_payments
  end

  def to_s
    id
  end

  # private
  def check_ballance
    self.has_outstanding_ballance = self.ballance > 0
    true
  end
end
