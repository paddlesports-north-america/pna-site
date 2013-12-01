class Payment < ActiveRecord::Base
  has_note
  has_note_attribute

  SOURCE = [ 'credit', 'check', 'cash' ]

  belongs_to :invoice
  attr_accessible :amount, :billing_name, :exp_date, :number, :payment_source

  validates :amount, :number, :billing_name, :payment_source, presence: true

end
