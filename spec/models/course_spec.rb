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

  it "should have many course participants" do
    @course.should have_many( :course_participants )
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
      @course.save
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

    it "should accept course_director_id via mass assignment" do
      director = FactoryGirl.create( :member )
      provider = FactoryGirl.create( :member )
      program = Program.first

      course = Course.create({
          :start_date => Date.today,
          :program_id => program.id,
          :course_provider_id => provider.id,
          :course_director_id => director.id
      })

      course.reload

      course.course_director.should == director
      course.course_director_id.should == director.id
      course.coaches.should_not be_empty
    end
  end

  describe "#assisting_coaches" do
    it "should accept assisting coach ids via mass assignment" do
      course = FactoryGirl.create( :course_with_director )
      coaches = []
      3.times do
        coaches << FactoryGirl.create( :member )
      end
      course.update_attributes( { :assisting_coach_ids => coaches.map{ |c| c.id } } )
      course.reload
      course.coaches.length.should == 4 # it comes with 1, which gets deleted, and we added 3 + course director
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

    it "should require start_date" do
      @course.start_date = nil
      @course.should_not be_valid
      @course.errors.should include( :start_date )
    end

    it "should not require an end date" do
      @course.end_date = nil
      @course.should be_valid
    end

    it "should require end date to be after start date" do
      @course.start_date = 1.day.from_now.to_date
      @course.end_date = 1.day.ago.to_date
      @course.should_not be_valid
      @course.errors.should include( :end_date )
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
