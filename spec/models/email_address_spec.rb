require 'spec_helper'

describe EmailAddress do

  it "should have a valid factory" do
    FactoryGirl.build( :email_address ).should be_valid
  end

  it "should belong to emailable" do
    e = FactoryGirl.build( :email_address )
    e.should belong_to( :emailable )
  end

  it "should require a valid email address" do
    e = FactoryGirl.build( :email_address, address: 'sladkfjlskdfj' )
    e.should_not be_valid
  end
end
