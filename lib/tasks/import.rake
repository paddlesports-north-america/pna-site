namespace :import do

  desc "Imports member data from csv"
  task :members, [ :path ] => :environment do |t,args|
    require 'CSV'
    failed_imports = 0

    File.open( args[ :path ], 'r' ).each_with_index do |line,index|
      next if index == 0

      CSV.parse(line) do |data|
        if Member.exists?({ :id => data[ 0 ]})
          member = Member.find( data[ 0 ] )
        else
          member = Member.new
        end

        member.id           = data[0]
        member.bcu_number   = data[2]
        member.first_name   = data[8]
        member.middle_name  = data[7]
        member.last_name    = data[6]
        member.notes        = data[25]
        member.birthdate    = Date.parse( data[24] ) unless data[24].blank?
        member.gender       = data[43] == 'Yes' ? Member::GENDER[ :male ] : Member::GENDER[ :female ]
        member.save!( :validate => false )
      end
    end
  end
end
