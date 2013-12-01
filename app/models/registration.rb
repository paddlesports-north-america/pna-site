class Registration < ActiveRecord::Base
  belongs_to :award
  belongs_to :member
  belongs_to :assessor, :class_name => "Member"

  has_one :note, :as => :noteable, :dependent => :delete

  serialize :prerequisites, Hash

  attr_accessible :assessor_id, :prerequisites, :trainer_id, :type, :award_id, :assessor, :trainer, :note_attributes, :member_id

  accepts_nested_attributes_for :note

  def self.prereq_accessor( *args )
    args.each do |arg|
      eval "
        def #{arg}
          ( self.prerequisites || {} )[:#{arg}]
        end
        def #{arg}=(v)
          self.prerequisites ||= {}
          unless v.class == TrueClass || v.class == FalseClass
            self.prerequisites[:#{arg}] = ( v == 'true' || v == '1' )
          else
            self.prerequisites[:#{arg}] = v
          end
        end
        attr_accessible :#{arg}
      "
    end
  end

end
