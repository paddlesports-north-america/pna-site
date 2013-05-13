default_dir = File.join( File.dirname( __FILE__ ), 'seeds' )

# Seed countries
require File.join( default_dir, 'countries.rb' )

# Seed states
require File.join( default_dir, 'states.rb' )

# Seed awards
require File.join( default_dir, 'awards.rb' )

# Seed programs
require File.join( default_dir, 'programs.rb' )
