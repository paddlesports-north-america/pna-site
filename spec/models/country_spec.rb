require 'spec_helper'

describe Country do

  describe "#states" do
    it "should have many states" do
      FactoryGirl.build( :country ).should have_many( :states )
    end
  end

  describe "#has_states?" do
    it "should be true if the country has states" do
      c = FactoryGirl.create( :country_with_states )
      c.has_states?.should be_true
    end

    it "should be false if country has no states" do
      c = FactoryGirl.create( :country )
      c.has_states?.should_not be_true
    end
  end

  describe "#valid?" do

    it "should be valid with all properties present" do
      FactoryGirl.build( :country ).should be_valid
    end

    it "should be invalid without :iso" do
      c = FactoryGirl.build( :country, :iso => nil )
      c.should_not be_valid
    end

    it "should validate :iso length to 2" do
      c = FactoryGirl.build( :country, :iso => "AB" )
      c.should be_valid

      c.iso = "ABC"
      c.should_not be_valid

      c.iso = ""
      c.should_not be_valid
    end

    it "should be invalid without :iso3" do
      c = FactoryGirl.build( :country, :iso3 => nil )
      c.should_not be_valid
    end

    it "should validate :iso3 length to 3" do
      c = FactoryGirl.build( :country, :iso3 => "ABC" )
      c.should be_valid

      c.iso3 = "AB"
      c.should_not be_valid

      c.iso3 = ""
      c.should_not be_valid
    end

    it "should be invalid without :iso_name" do
      c = FactoryGirl.build( :country, :iso_name => nil )
      c.should_not be_valid
    end

    it "should be invalid without :name" do
      c = FactoryGirl.build( :country, :name => nil )
      c.should_not be_valid
    end

    it "should be invalid without :numcode" do
      c = FactoryGirl.build( :country, :numcode => nil )
      c.should_not be_valid
    end
  end

end
