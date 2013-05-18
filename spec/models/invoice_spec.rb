require 'spec_helper'

describe Invoice do

  before :each do
    @invoice = FactoryGirl.build( :invoice )
  end

  it "should have a valid factory" do
    @invoice.should be_valid
  end

  it "should belong to member" do
    @invoice.should belong_to( :member )
  end

  it "shoudl require member" do
    @invoice.member = nil
    @invoice.should_not be_valid
    @invoice.errors.should include( :member )
  end

  it "should have many line items" do
    @invoice.should have_many( :line_items )
  end

  describe "#total" do
    it "should calculate total as the sum of line items" do
      base = FactoryGirl.attributes_for( :line_item ).except( :invoice )
      @invoice.line_items.build( base.merge( { :cost => 2, :quantity => 2 } ) )
      @invoice.line_items.build( base.merge( { :cost => 6, :quantity => 1 } ) )
      @invoice.total.should == 10
    end
  end
end
