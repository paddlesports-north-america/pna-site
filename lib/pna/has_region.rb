module Pna
  module HasRegion
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_region
        send :include, RegionInstanceMethods

        belongs_to :country
        belongs_to :state

        validates :state, :presence => true, :if => Proc.new { |a| !a.country.nil? && a.country.has_states? }

        validate :state_against_country, :unless => Proc.new { |a| a.state.nil? || a.country.nil? }
      end

      module RegionInstanceMethods
        private
        def state_against_country
          unless state.nil? || state.country == country
            errors.add( :state )
          end
        end
      end
    end
  end
end
