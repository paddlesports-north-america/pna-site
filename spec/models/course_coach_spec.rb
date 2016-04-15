require 'spec_helper'

describe CourseCoach do

  before :each do
    @coach = FactoryGirl.build( :course_coach )
  end

  it "should have a valid factory" do
    @coach.should be_valid
  end

  it "should have a valid course_director factory" do
    c = FactoryGirl.build( :course_director )
    c.should be_valid
    c.is_director.should be_truthy
  end

  it "should belong to member" do
    @coach.should belong_to( :member )
  end

  it "should belong to course" do
    @coach.should belong_to( :course )
  end

  it "should require member" do
    @coach.member = nil
    @coach.should_not be_valid
    @coach.errors.should include( :member )
  end

  it "should require require course" do
    @coach.course = nil
    @coach.should_not be_valid
    @coach.errors.should include( :course )
  end

end
