module CoachesHelper
  
  def highest_awards_by_type( coach, type )
    highest_awards_in( coach.awards.where( :award_type => type ) )
  end

  def highest_awards_in( awards )
    awards.select { |a| ( a.children & awards ).empty? }
  end

  def region_coaches_by_local( region, coaches )
    coaches.select { |l,_| region.locations.include? l }
  end
  
  def domain_name(uri)
    URI.parse(uri).host[/\w+\.\w+(\.\w{2})?\Z/]
  end
end
