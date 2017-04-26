require 'spec_helper'

describe CourseParticipant do

  before :each do
    @course_participant = FactoryGirl.build( :course_participant )
  end

  it "should have a valid factory" do
    @course_participant.should be_valid
  end

  describe "#valid?" do
    it "should require course" do
      @course_participant.course = nil
      @course_participant.should_not be_valid
      @course_participant.errors.should include( :course )
    end

    it "should require member" do
      @course_participant.member = nil
      @course_participant.should_not be_valid
      @course_participant.errors.should include( :member )
    end
  end

  describe "creates quals" do
    it "should have create qual if not there" do
      @course_participant.member.qualifications.length.should == 0
      @course_participant.assign_qualifications
      @course_participant.member.qualifications.length.should == 1
    end

    it "should update most recent award if there" do
      @course_participant.assign_qualifications
      @course_participant.member.qualifications.length.should == 1
      new_award_date = Date.today.advance(:years => 1)
      new_award_date.should_not == @course_participant.member.qualifications[0].most_recent_award
      @course_participant.course.end_date = new_award_date
      @course_participant.assign_qualifications
      @course_participant.member.qualifications.reload
      @course_participant.member.qualifications[0].most_recent_award.should == new_award_date
    end
  end
end
