# namespace :reports do 

#   require 'CSV'

#   task :coaches, [ :path ] => :environment do |t,args|
#     coaches = Member.includes( :awards ).where( 'awards.award_type' => 'coaching' ).select{ |m| m.membership_status != :error }
#     data = coaches.map { |c|
#       cdata = [
#         c.id,
#         c.first_name,
#         c.last_name
#       ]

#       c.awards.where( 'award_type' => 'coaching' ).each do |a|
#         cdata.push(a.name)
#       end

#       cdata
#     }

#     CSV.open( 'coaches-report.csv', 'wb' ) do |csv|
#       data.each do |d|
#         csv << d
#       end
#     end
#   end
# end