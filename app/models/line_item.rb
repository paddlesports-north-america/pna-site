class LineItem < ActiveRecord::Base
  belongs_to :invoice
  attr_accessible :cost, :description, :quantity, :invoice_id

  validates :cost, :description, :quantity, :presence => true

  def total
    quantity * cost
  end
end
