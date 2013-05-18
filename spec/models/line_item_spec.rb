require 'spec_helper'

describe LineItem do

  before :each do
    @line_item = FactoryGirl.build( :line_item )
  end

  it "should have a valid factory" do
    @line_item.should be_valid
  end

  describe "#total" do
    it "should calculate total as product of cost and quantity" do
      @line_item.cost = 2
      @line_item.quantity = 2
      @line_item.total.should == 4
    end
  end
end
