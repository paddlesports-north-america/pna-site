class HomeController < ApplicationController

  layout "front", :only => [ :index ]

  def index
  end

  def about
  end

  def calendar
  end
end
