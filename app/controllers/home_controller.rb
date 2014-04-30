class HomeController < ApplicationController

  layout "front", :only => [ :index ]
  layout "landing", :only => [ :landing ]

  def landing
  end

  def index
  end

  def about
  end

  def calendar
  end

  def paddlers
  end

  def coaches
  end

  def membership
  end

  def contact
  end

end
