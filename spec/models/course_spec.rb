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

  it "should have many course coaches" do
    @course.should have_many( :course_coaches )
  end

  it "should have many coaches through course_coach" do
    @course.should have_many( :coaches ).through( :course_coaches )
  end

  it "should have a valid factory with coaches" do
    course = FactoryGirl.create( :course_with_coach )
    course.should be_valid
    course.coaches.should_not be_empty
    course.course_coaches.should_not be_empty
  end

  describe '#course_director' do

    it "should have a valid factory with a course director" do
      c = FactoryGirl.create( :course_with_director )
      c.should be_valid
      c.course_director.should_not be_nil
    end

    it "should respond to course_director" do
      @course.should respond_to( :course_director )
      @course.should respond_to( :course_director= )
    end

    it "should accept a member and create a new course_coach" do
      before_count = @course.course_coaches.length
      @course.course_director = FactoryGirl.create( :member )
      @course.course_coaches.length.should == before_count + 1
    end

    it "should replace the previous course director on assignment" do
      course = FactoryGirl.create( :course_with_director )
      previous_director = course.course_director
      course.course_director = FactoryGirl.create( :member )
      course.course_director.should_not eq( previous_director )
      course.save
      CourseCoach.where( :course_id => course.id, :is_director => true ).count.should == 1
    end
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
