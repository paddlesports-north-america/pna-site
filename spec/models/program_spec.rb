require 'spec_helper'

describe Program do

  before :each do
    @program = FactoryGirl.build( :program )
  end

  it "should have a valid factory" do
    @program.should be_valid
  end

  describe "#valid?" do
    it "should require name" do
      @program.name = nil
      @program.should_not be_valid
    end
  end

end
