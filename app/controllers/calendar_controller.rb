class CalendarController < ApplicationController

  def index
    @courses ||= Course.where( 'show_on_calendar = true AND start_date >= ?', DateTime.now.beginning_of_month ).order( :start_date ).group_by { |c| c.start_date.beginning_of_month }
  end

end