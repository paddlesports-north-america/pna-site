require 'spec_helper'

describe PhoneNumber do

  it "should have a valid factory" do
    FactoryGirl.build( :phone_number ).should be_valid
  end

  it "should belong to phoneable" do
    p = FactoryGirl.build( :phone_number )
    p.should belong_to( :phoneable )
  end

  it "should require a number" do
    p = FactoryGirl.build( :phone_number, :number => nil )
    p.should_not be_valid
  end

  it "should require a valid number" do
    p = FactoryGirl.build( :phone_number, :number => '123' )
    p.should_not be_valid

    p = FactoryGirl.build( :phone_number, :number => '12abc2o349q8hpouvnp98293829839283928392833' )
    p.should_not be_valid
  end

  it "should accept a preformatted number" do
    p = FactoryGirl.build( :phone_number, :number => '1 (360) 555-4323' )
    p.should be_valid
  end

  it "should accept a preformatted european number" do
    p = FactoryGirl.build( :phone_number, :number => '+44 (0) 1407 765 550' )
    p.should be_valid
  end


  it "should properly format a north american phone number" do
    p = FactoryGirl.build( :phone_number, :number => '3605554567' )
    p.format_number.should == '(360) 555-4567'
  end

  it "should properly format a european number" do
    p = FactoryGirl.build( :phone_number, :number => '+441407765550' )
    p.format_number.should == '+44 (0) 1407 765 550'
  end

  it "should format number before save" do
    p = FactoryGirl.build( :phone_number, :number => '3605554567' )
    p.save
    p.number.should == '(360) 555-4567'
  end
end
