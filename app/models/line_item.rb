class LineItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product

  attr_accessible :cost, :quantity, :invoice_id, :product_id

  validates :cost, :quantity, :presence => true

  # @TODO move to decorator
  def description
    product.description
  end

  def total
    quantity * cost
  end

end
