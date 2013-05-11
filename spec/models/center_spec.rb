require 'spec_helper'

describe Center do

  before :each do
    @center = FactoryGirl.build( :center )
  end

  it "should have a valid factory" do
    @center.should be_valid
  end

  it "should have many phone numbers" do
    @center.should have_many( :phone_numbers )
  end

  it "should have a valid factory with phone numbers" do
    c = FactoryGirl.create( :center_with_phone_numbers )
    c.should be_valid
    c.phone_numbers.should_not be_empty
  end

  it "should destroy child phone numbers" do
    c = FactoryGirl.create( :center_with_phone_numbers )
    pid = c.phone_numbers.first.id
    c.destroy
    PhoneNumber.exists?(pid).should_not be_true
  end

  it "should have many email addresses" do
    @center.should have_many( :email_addresses )
  end

  it "should have a valid factory with email addresses" do
    c = FactoryGirl.create( :center_with_email_addresses )
    c.should be_valid
    c.email_addresses.should_not be_empty
  end

  it "should destroy child email addresses on destroy" do
    c = FactoryGirl.create( :center_with_email_addresses )
    eid = c.email_addresses.first.id
    c.destroy
    EmailAddress.exists?( eid ).should_not be_true
  end

  it "should have many addresses" do
    @center.should have_many( :addresses )
  end

  it "should have a valid factory with addresses" do
    c = FactoryGirl.create( :center_with_addresses )
    c.should be_valid
    c.addresses.should_not be_empty
  end

  it "should destroy child addresses on destroy" do
    c = FactoryGirl.create( :center_with_addresses )
    aid = c.addresses.first.id
    c.destroy
    Address.exists?( aid ).should_not be_true
  end

  it "should have and belong to many members" do
    @center.should have_and_belong_to_many( :members )
  end

  it "should have a valid factory with members" do
    c = FactoryGirl.create( :center_with_members )
    c.should be_valid
    c.members.should_not be_empty
  end

  describe "#valid?" do

    it "should require name" do
      @center.name = nil
      @center.should_not be_valid
      @center.errors.should include( :name )
    end

    it "should require url" do
      @center.url = nil
      @center.should_not be_valid
      @center.errors.should include( :url )
    end
  end
end
