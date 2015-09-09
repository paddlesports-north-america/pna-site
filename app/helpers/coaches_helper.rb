module CoachesHelper
  
  def region_coaches_by_local( region, coaches )
    coaches.select { |l,_| region.locations.include? l }
  end
end
