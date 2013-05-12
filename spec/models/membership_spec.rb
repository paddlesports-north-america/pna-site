require 'spec_helper'

describe Membership do

  before :each do
    @membership = FactoryGirl.create( :membership )
  end

  it "should have a valid factory" do
    @membership.should be_valid
  end

  it "should belong to member" do
    @membership.should belong_to( :member )
  end

  describe "#valid?" do

    it "should require expiration date" do
      @membership.expiration_date = nil
      @membership.should_not be_valid
      @membership.errors.should include( :expiration_date )
    end

    it "should require organization" do
      @membership.organization = nil
      @membership.should_not be_valid
      @membership.errors.should include( :organization )
    end

    it "should require organization to be BCU or PNA" do
      @membership.organization = 'ABC'
      @membership.should_not be_valid
      @membership.errors.should include( :organization )
    end
  end
end
