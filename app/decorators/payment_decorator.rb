class PaymentDecorator < Draper::Decorator
  decorates :payment
  delegate_all

  # def payment_source
  #   I18n.t("pna.payment_sources.#{source.payment_source}")
  # end
end
