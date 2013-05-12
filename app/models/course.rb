class Course < ActiveRecord::Base
  has_paper_trail

  has_region

  belongs_to :program
  belongs_to :course_provider, :class_name => 'Member'
  belongs_to :center

  has_many :course_coaches, :dependent => :delete_all, :validate => true
  has_many :coaches, :through => :course_coaches, :source => :member

  attr_accessible :date, :venue

  validates :program, :course_provider, :date, :presence => true

  def course_director
    unless course_coach_director.nil?
      course_coach_director.member
    else
      nil
    end
  end

  # there can be only one
  def course_director=(member)
    unless course_coach_director.nil?
      course_coach_director.delete
    end

    @course_coach_director = self.course_coaches.build( { :member => member, :is_director => true } )
  end

  def assisting_coaches
    self.course_coaches.where( :is_director => false ).map { |c| c.member }
  end

  private

  def course_coach_director
    @course_coach_director ||= self.course_coaches.where( :is_director => true ).first
  end
end
