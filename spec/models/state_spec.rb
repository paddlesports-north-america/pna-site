require 'spec_helper'

describe State do
  it "should have a valid factory" do
    FactoryGirl.build( :state ).should be_valid
  end

  it "should belong to country" do
    FactoryGirl.build( :state ).should belong_to( :country )
  end

  it "should require abbr" do
    s = FactoryGirl.build( :state, :abbr => nil )
    s.should_not be_valid
  end

  it "should not be valid with a blank abbr" do
    s = FactoryGirl.build( :state, :abbr => '' )
    s.should_not be_valid
  end

  it "should require abbr to have length 2" do
    s = FactoryGirl.build( :state, :abbr => 'ABC' )
    s.should_not be_valid
  end

  it "should require name" do
    FactoryGirl.build( :state, :name => nil ).should_not be_valid
  end

  it "should require country" do
    FactoryGirl.build( :state, :country => nil ).should_not be_valid
  end
end
