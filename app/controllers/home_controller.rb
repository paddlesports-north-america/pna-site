class HomeController < ApplicationController

  def initialize
    super
    # Used on both the documents and membership pages.
    @yearly_label = 'Yearly Membership'
    @fee_label = 'Fee'
  end

  # layout "front", :only => [ :index ]
  # layout "landing", :only => [ :landing ]

  def landing
  end

  def index
  end

  def about
    @regions = Region.includes( :rco, region_locations: [ :location ] ).order( :name ).all
  end

  def paddlers
  end

  def documents
    @program_label = 'Program'
    @member_label = 'Member'
    @nonmember_label = 'Non-Member'
  end

  def membership
  end

  def contact
  end
  
  def candidates
    redirect_to :about
  end

end
