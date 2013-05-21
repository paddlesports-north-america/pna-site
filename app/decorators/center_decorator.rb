class CenterDecorator < Draper::Decorator
  decorates :member
  delegate_all

  def email_address
    source.email_addresses.first
  end

  def phone_number
    source.phone_numbers.first
  end

  def address
    source.addresses.first
  end

end
