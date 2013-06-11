module Pna
  module HasNote
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_note
        has_one :note, :as => :noteable
        after_initialize lambda { self.note ||= Note.new }
        accepts_nested_attributes_for :note
        attr_accessible :note_attributes, :note
      end
    end
  end
end
