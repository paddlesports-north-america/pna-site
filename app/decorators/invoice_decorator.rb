class InvoiceDecorator < Draper::Decorator
  decorates :invoice
  delegate_all
  decorates_association :line_items
  decorates_association :payments

  def total
    h.number_to_currency( source.total )
  end

  def line_item_list
    list = source.line_items.map { |l| "<li>#{l.product.description}</li>"}
    "<ul>#{list.join('')}</ul>".html_safe
  end
end
