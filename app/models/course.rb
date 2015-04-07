class Course < ActiveRecord::Base
  #has_paper_trail

  has_region

  scope :upcoming, where( 'start_date >= ?', Date.today )
  scope :past, where( 'start_date < ?', Date.today )
  scope :calendar, where( 'show_on_calendar = ? and start_date >= ?', true, Date.today)

  belongs_to :program
  belongs_to :course_provider, :class_name => 'Member'
  belongs_to :center

  has_many :course_coaches, :dependent => :delete_all, :validate => true
  has_many :coaches, :through => :course_coaches, :source => :member

  has_many :course_participants, :dependent => :delete_all
  # has_many :students, :through => :course_participants, :source => :member
  accepts_nested_attributes_for :course_participants

  attr_accessible :start_date, :end_date, :venue, :program_id, :course_provider_id,
                  :center_id, :state_id, :country_id, :course_director_id,
                  :show_on_calendar, :assisting_coach_ids,
                  :course_participants_attributes

  attr_writer :course_director_id
  attr_writer :assisting_coach_ids

  after_save :set_course_director
  after_save :set_coaches

  validates :program, :course_provider, :start_date, :presence => true
  validate :end_date_after_start_date
  validate :has_course_director?

  def end_date_after_start_date
    errors.add( :end_date ) unless start_date.nil? || end_date.nil? || end_date >= start_date
  end
  
  def has_course_director?
    !@course_director_id.empty?
  end

  def course_director_id
    @course_director_id || CourseCoach.where( { :course_id => self.id, :is_director => true } ).pluck( :member_id ).first
  end

  def set_course_director
    if @course_director_id.empty?
      self.course_director = self.course_provider
    else
      self.course_director = Member.find( @course_director_id )
    end
  end

  def course_director
    cc = self.course_coaches.where({ :is_director => true }).first
    cc.nil? ? nil : cc.member
  end

  def course_director=(member)
    unless member == course_director
      self.course_coaches.where( { :is_director => true } ).delete_all
      self.course_coaches.create( { :member_id => member.id, :is_director => true } )
    end
  end

  def assisting_coach_ids=(val)
    @assisting_coach_ids = val.reject { |v| v.empty? }.join(',')
  end

  def assisting_coach_ids
    @assisting_coach_ids || ( self.course_coaches.where( :is_director => false ).any? ? self.course_coaches.where( :is_director => false ).pluck( :member_id ).join(',') : nil ) #[self.course_coaches.where( :is_director => false ).pluck( :member_id ).join(',')]
  end

  def set_coaches
    unless @assisting_coach_ids.empty?
      acids = @assisting_coach_ids.split(',')
      original = self.course_coaches.where( :is_director => false ).pluck( :member_id )
      self.course_coaches.where( :member_id => original - acids ).delete_all
      add = acids - original
      add.each { |id|
        self.course_coaches.create( { :member_id => id } )
      }
    end
  end

  def assisting_coaches
    self.course_coaches.where( :is_director => false ).map { |c| c.member }
  end

  def to_s
    unless program.nil?
      "#{program.name}: ##{id}"
    else
      "##{id}"
    end
  end
end
