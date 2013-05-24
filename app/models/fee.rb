class Fee < ActiveRecord::Base
  attr_accessible :amount, :category, :description

  def to_s
    description
  end
end
