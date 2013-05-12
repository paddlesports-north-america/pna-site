# This seems like a bad idea, rafactoring to come...
# @TODO: reevaluate this module shit show
module Pna
  module ModelHelpers

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

      def has_contact_info
        has_many :phone_numbers,
          :as => :phoneable,
          :dependent => :delete_all,
          :validate => true

        has_many :email_addresses,
          :as => :emailable,
          :dependent => :delete_all,
          :validate => true

        has_many :addresses,
          :as => :addressable,
          :dependent => :delete_all,
          :validate => true
      end

    end

  end
end
