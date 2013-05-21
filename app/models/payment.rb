class Payment < ActiveRecord::Base

  SOURCE = { :credit => 'credit', :check => 'check', :cash => 'cash' }

  belongs_to :invoice
  attr_accessible :amount, :billing_name, :exp_date, :number, :source

end
