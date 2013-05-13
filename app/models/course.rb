class Course < ActiveRecord::Base
  has_paper_trail

  has_region

  belongs_to :program
  belongs_to :course_provider, :class_name => 'Member'
  belongs_to :center

  has_many :course_coaches, :dependent => :delete_all, :validate => true
  has_many :coaches, :through => :course_coaches, :source => :member

  attr_accessible :date, :venue, :program_id, :course_provider_id,
                  :center_id, :state_id, :country_id, :course_director_id,
                  :show_on_calendar, :assisting_coach_ids

  attr_writer :course_director_id
  attr_writer :assisting_coach_ids

  after_save :set_course_director
  after_save :set_coaches

  validates :program, :course_provider, :date, :presence => true

  def course_director_id
    @course_director_id || CourseCoach.where( { :course_id => self.id, :is_director => true } ).pluck( :member_id ).first
  end

  def set_course_director
    unless @course_director_id.nil?
      self.course_director = Member.find( @course_director_id )
    end
  end

  def course_director
    cc = self.course_coaches.where({ :is_director => true }).first
    cc.nil? ? nil : cc.member
  end

  def course_director=(member)
    self.course_coaches.where( { :is_director => true } ).delete_all
    self.course_coaches.create( { :member_id => member.id, :is_director => true } )
  end

  def assisting_coach_ids
    @assisting_coach_ids || self.course_coaches.where( :is_director => false ).pluck( :member_id )
  end

  def set_coaches
    unless @assisting_coach_ids.nil?
      @assisting_coach_ids.each { |id|
        self.course_coaches.create( { :member_id => id } )
      }
    end
  end

  def assisting_coaches
    self.course_coaches.where( :is_director => false ).map { |c| c.member }
  end

  def to_s
    "#{program.name}: ##{id}"
  end
end
