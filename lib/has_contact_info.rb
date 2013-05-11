module HasContactInfo

  def self.included( base )
    base.has_many :phone_numbers,
      :as => :phoneable,
      :dependent => :delete_all,
      :validate => true

    base.has_many :email_addresses,
      :as => :emailable,
      :dependent => :delete_all,
      :validate => true

    base.has_many :addresses,
      :as => :addressable,
      :dependent => :delete_all,
      :validate => true
  end

end
