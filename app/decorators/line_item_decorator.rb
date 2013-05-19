class LineItemDecorator < Draper::Decorator
  decorates :line_item
  delegate_all

  def total
    h.number_to_currency( source.total )
  end

  def cost
    h.number_to_currency( source.cost )
  end
end
