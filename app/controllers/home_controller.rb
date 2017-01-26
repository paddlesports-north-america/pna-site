class HomeController < ApplicationController

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

  def coaches
    # Note that this controls the "Documents" tab
    @program_label = 'Program'
    @member_label = 'Member'
    @nonmember_label = 'Non-Member'
    @yearly_label = 'Yearly Membership'
    @fee_label = 'Fee'
  end

  def membership
    @yearly_label = 'Yearly Membership'
    @fee_label = 'Fee'
  end

  def contact
  end
  
  def candidates
    redirect_to :about
  end

end
