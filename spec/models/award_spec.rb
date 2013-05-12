require 'spec_helper'

describe Award do

  before :each do
    @award = FactoryGirl.build( :award )
  end

  it "should have a valid factory" do
    @award.should be_valid
  end

  describe "#valid?" do

    it "shoudl requrie name" do
      @award.name = nil
      @award.should_not be_valid
      @award.errors.should include( :name )
    end
  end

end
