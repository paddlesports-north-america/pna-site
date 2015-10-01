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
          
        search_methods :addresses_state_eq
        
        scope :addresses_state_eq, lambda { |state_id|
          self.joins(:addresses).where( 'addresses.state_id = ?', state_id )
        }
        
        search_methods :addresses_country_eq
        
        scope :addresses_country_eq, lambda { |country_id|
          self.joins(:addresses).where( 'addresses.country_id = ?', country_id )
        }
      end
    end
    
    def public_email_addresses
      self.email_addresses.where( :public => true )  
    end
    
    def public_phone_numbers
      self.phone_numbers.where( :public => true )
    end
    
    def public_addresses
      self.addresses.where( :public => true )
    end
  end
end
