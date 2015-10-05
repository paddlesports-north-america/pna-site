module CoachesHelper
  
  
  def region_coaches_by_local( region, coaches )
    coaches.select { |l,_| region.locations.include? l }
  end
  
  def domain_name(uri)
    URI.parse(uri).host[/\w+\.\w+(\.\w{2})?\Z/]
  end
end
