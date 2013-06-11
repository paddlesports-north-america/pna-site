module Pna
  module HasContactInfo
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
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
