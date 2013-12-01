class CoachingRegistration < Registration

  belongs_to :trainer, :class_name => "Member"

  # has_one :note, :as => :noteable, :dependent => :delete
  # attr_accessible :note_attributes
  # accepts_nested_attributes_for :note

  prereq_accessor :relevant_star_award, :relevant_safety_training, :first_aid, :pre_req_coaching_award

  # after_initialize :set_prerequisites

  # def set_prerequisites
  #   self.prerequisites ||= {
  #     :relevant_star_award => false,
  #     :relevant_safety_training => false,
  #     :first_aid => false,
  #     :pre_req_coaching_award => false
  #   } if self.new_record?
  # end

  def to_s
    award.name
  end
end
