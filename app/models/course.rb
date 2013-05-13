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
                  :show_on_calendar

  attr_writer :course_director_id

  after_save :set_course_director

  validates :program, :course_provider, :date, :presence => true

  def course_director_id
    @course_director_id || CourseCoach.where( { :course_id => self.id, :is_director => true } ).pluck( :member_id ).first
  end

  def set_course_director
    unless @course_director_id.nil?
      self.course_coaches.create({ :member_id => @course_director_id, :is_director => true })
    end
  end

  def course_director
    cc = self.course_coaches.where({ :is_director => true }).first
    cc.nil? ? nil : cc.member
  end

  def course_director=(member)
    cc = CourseCoach.where( { :course_id => self.id, :is_director => true } )
    cc.destroy unless cc.nil?
    self.course_coaches.create( { :member_id => member.id, :is_director => true } )
  end

  # def course_director
  #   unless course_coach_director.nil?
  #     course_coach_director.member
  #   else
  #     nil
  #   end
  # end

  # # there can be only one
  # def course_director=(member)
  #   unless course_coach_director.nil?
  #     course_coach_director.delete
  #   end

  #   @course_coach_director = self.course_coaches.build( { :member => member, :is_director => true } )
  # end

  # # def course_director_id=(id)
  # #   self.course_director = Member.find(id)
  # # end

  # def course_director_id
  #   if @course_director_id
  #     @course_director_id
  #   elsif course_director
  #     self.course_director.id
  #   else
  #     nil
  #   end
  # end

  # def assisting_coaches
  #   self.course_coaches.where( :is_director => false ).map { |c| c.member }
  # end

  # private
  # def set_course_director
  #   self.course_director = Member.find( @course_director_id ) if @course_director_id
  # end

  # def course_coach_director
  #   @course_coach_director ||= self.course_coaches.where( :is_director => true ).first
  # end
end
