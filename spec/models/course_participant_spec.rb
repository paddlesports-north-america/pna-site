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

end
