require 'spec_helper'

describe Qualification do

  before :each do
    @qualification = FactoryGirl.build( :qualification )
  end

  it "should have a valid factory" do
    @qualification.should be_valid
  end

  describe "#valid?" do
    it "should require member" do
      @qualification.member = nil
      @qualification.should_not be_valid
      @qualification.errors.should include( :member )
    end

    it "should require award" do
      @qualification.award = nil
      @qualification.should_not be_valid
      @qualification.errors.should include( :award )
    end
  end

end
