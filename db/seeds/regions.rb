
# Set up regions and region location defaults

def add_states_to_region(r, abbrs)
  rs = State.where( 'abbr in (?)', abbrs )
  rs.each { |s| r.add_location( s ) }
end

r = Region.create({ name: 'Northeast' } )
add_states_to_region( r, %w{ CT, DE, ME, MD, MA, NH, NJ, NY, PA, RI, VT, VA, WV } )


r = Region.create({ name: 'Southeast' } )
add_states_to_region(r, %w{ AL, AR, FL, GA, LA, MS, NC, SC, TN } )

r = Region.create({ name: 'Midwest' } )
add_states_to_region(r, %w{ IL, IN, IA, KY, MI, MO, OH, WI } )

r = Region.create({ name: 'West North Central' } )
add_states_to_region(r, %w{ MT, NE, ND, SD, WY } )

r = Region.create({ name: 'West South Central' } )
add_states_to_region(r, %w{ AZ, CO, KS, NM, OK, TX, UT } )

r = Region.create({ name: 'Northwest' } )
add_states_to_region(r, %w{ AK, ID, OR, WA } )

r = Region.create({ name: 'West' } )
add_states_to_region( r, %w{ CA, HI, NV } )

r = Region.create({ name: 'Eastern Canada' } )
add_states_to_region( r, %{ MB, NB, NL, NS, NU, ON, PE, QC } )

r = Region.create({ name: 'Western Canada' } )
add_states_to_region( r, %w{ AB, BC, NT, YT } )

r = Region.create({ name: 'Mexico' } )
r.add_location( Country.find_by_iso( 'MX' ) )