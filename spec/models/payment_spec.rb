require 'spec_helper'

describe Payment do

  before :each do
    @payment = FactoryGirl.build( :payment )
  end

  it "should have a valid factory" do
    @payment.should be_valid
  end

  it "should belong to invoice" do
    @payment.should belong_to( :invoice )
  end
end
