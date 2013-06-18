default_dir = File.join( File.dirname( __FILE__ ), 'seeds' )

# Seed countries
require File.join( default_dir, 'countries.rb' )

# Seed states
require File.join( default_dir, 'states.rb' )

# Seed programs and awards
require File.join( default_dir, 'programs.rb' )


AdminUser.create( { :email => 'admin@paddlesportsnorthamerica.com', :password => 'password', :password_confirmation => 'password' } )
AdminUser.create( { :email => 'bill.akt@gmail.com', :password => 'password', :password_confirmation => 'password' } )
AdminUser.create( { :email => 'scottfairty@gmail.com', :password => 'password', :password_confirmation => 'password' } )
