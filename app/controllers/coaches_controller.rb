class CoachesController < ApplicationController
  def index
    @coaches = Member.includes( :awards ).where( :show_on_coaches_page => true, 'awards.award_type' => 'coaching' ).group_by { |coach|
      unless coach.addresses.empty?
        unless coach.addresses.first.state.nil?
          coach.addresses.first.state
        else
          coach.addresses.first.country
        end
      end
    }.select{ |m| m.membership_status != :error }.sort_by { |k,v| k.name }
    
    @regions = Region.all #.order( :name )
  end
end
