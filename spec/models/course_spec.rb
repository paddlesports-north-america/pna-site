require 'spec_helper'

describe Course do

  before :each do
    @course = FactoryGirl.build( :course )
  end

  it "should have a valid factory" do
    @course.should be_valid
  end

  it "should belong to program" do
    @course.should belong_to( :program )
  end

  it "should belong_to course provider" do
    @course.should belong_to( :course_provider )
  end

  it "should belong_to center" do
    @course.should belong_to( :center )
  end

  it "should belong to state" do
    @course.should belong_to( :state )
  end

  it "should belong_to country" do
    @course.should belong_to( :country )
  end

  describe "#valid?" do
    it "should require program" do
      @course.program = nil
      @course.should_not be_valid
      @course.errors.should include( :program )
    end

    it "should require course_provider" do
      @course.course_provider = nil
      @course.should_not be_valid
      @course.errors.should include( :course_provider )
    end

    it "should require date" do
      @course.date = nil
      @course.should_not be_valid
      @course.errors.should include( :date )
    end

    it "should not require center" do
      @course.center = nil
      @course.should be_valid
    end

    it "should not require venue" do
      @course.venue = nil
      @course.should be_valid
    end
  end
end
