module Pna
  module HasAwardScope
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_award_scope
        Pna::ProgramType::ALL.each do |t|
          scope t.to_sym, where( :award_type => t )
        end
      end
    end
  end
end