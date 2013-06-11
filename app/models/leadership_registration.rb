class LeadershipRegistration < Registration

  after_initialize :set_prerequisites

  prereq_accessor :relevant_leadership_training, :relevant_safety_training, :first_aid, :registration_fee

  def set_prerequisites
    self.prerequisites = {
      :relevant_leadership_training => false,
      :relevant_safety_training => false,
      :first_aid => false,
      :registration_fee => false
    } if self.new_record?
  end

end
