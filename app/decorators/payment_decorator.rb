class PaymentDecorator < Draper::Decorator
  decorates :payment
  delegate_all

  def source

  end
end
