class LineItem < ActiveRecord::Base
  belongs_to :invoice
  attr_accessible :cost, :description, :quantity, :invoice_id

  validates :invoice, :cost, :description, :quantity, :presence => true

  def total
    quantity * cost
  end
end
