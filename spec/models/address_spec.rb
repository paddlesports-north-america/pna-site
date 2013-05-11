require 'spec_helper'

describe Address do

  before :each do
    @address = FactoryGirl.build( :address )
  end

  it "should have a valid factory" do
    @address.should be_valid
  end

  it "should belong to state" do
    @address.should belong_to( :state )
  end

  it "should belong to country" do
    @address.should belong_to( :country )
  end

  it "should belong to addressable" do
    @address.should belong_to( :addressable )
  end

  describe "#valid?" do
    it "should require address1" do
      a = FactoryGirl.build( :address, :address1 => nil )
      a.should_not be_valid
      a.errors.should include( :address1 )
    end

    it "should not require address2" do
      a = FactoryGirl.build( :address, :address2 => nil )
      a.should be_valid
    end

    it "should require city" do
      a = FactoryGirl.build( :address, :city => nil )
      a.should_not be_valid
      a.errors.should include( :city )
    end

    it "should require a postal code" do
      a = FactoryGirl.build( :address, :postal_code => nil )
      a.should_not be_valid
      a.errors.should include( :postal_code )
    end

    it "should require addressable" do
      a = FactoryGirl.build( :address, :addressable => nil )
      a.should_not be_valid
      a.errors.should include( :addressable )
    end

    it "should require country" do
      a = FactoryGirl.build( :address, :country => nil )
      a.should_not be_valid
      a.errors.should include( :country )
    end

    it "should require a state if country has states" do
      a = FactoryGirl.build( :manual_address, :country => FactoryGirl.create( :country_with_states ), :state => nil )
      a.should_not be_valid
      a.errors.should include( :state )
    end

    it "should be invalid if state does not belong to country" do
      c1 = FactoryGirl.create( :country_with_states )
      c2 = FactoryGirl.create( :country_with_states )

      a = FactoryGirl.build( :manual_address, :country => c1, :state => c2.states.last )

      a.should_not be_valid
      a.errors.should include( :state )
    end
  end

end
