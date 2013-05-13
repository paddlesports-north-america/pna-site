namespace :import do

  def current_admin_user
    AdminUser.first
  end

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
        # member.notes        = data[25]
        member.birthdate    = Date.parse( data[24] ) unless data[24].blank?
        member.gender       = data[43] == 'Yes' ? Member::GENDER[ :male ] : Member::GENDER[ :female ]
        member.save!( :validate => false )

        comment = ActiveAdmin::Comment.new( { :body => data[25], :namespace => 'admin' } )
        comment.author = AdminUser.first
        comment.resource = member
        comment.save

        #PNA membership info
        unless data[3].blank?
          member.memberships.create({
              :expiration_date => Date.parse( data[3] ),
              :organization => Membership::ORGANIZATION[ :pna ],
              :printed_on => data[49].blank? ? nil : Date.parse( data[49] ),
              :sent => data[48] == 'Yes'
            })
        end

        #BCU membership info
        unless data[4].blank?
          member.memberships.create({
            :expiration_date => Date.parse( data[4] ),
            :organization => Membership::ORGANIZATION[ :bcu ]
          })
        end

        addr = member.addresses.build({
          :address1     => data[9],
          :address2     => data[10],
          :city         => data[11],
          :postal_code  => data[13]
        })

        unless data[12].blank?
          state = State.find_by_abbr( data[12] )
          unless state.nil?
            addr.state = state
          end
        end

        if !data[14].blank? && data[14].length == 2
          addr.country = Country.find_by_iso( data[14] )
        else
          addr.country = Country.find_by_iso3( data[14] )
        end

        addr.save

        unless data[15].blank?
          member.phone_numbers.create({
            :label => 'Home',
            :number => data[15]
          })
        end

        unless data[16].blank?
          member.phone_numbers.create({
            :label => 'Home',
            :number => data[16]
          })
        end

        unless data[17].blank?
          member.phone_numbers.create({
            :label => 'Cell',
            :number => data[17]
          })
        end

        unless data[18].blank?
          member.phone_numbers.create({
            :label => 'Work',
            :number => data[18]
          })
        end

        unless data[19].blank?
          member.phone_numbers.create({
            :label => 'Home Fax',
            :number => data[19]
          })
        end

        unless data[20].blank?
          member.phone_numbers.create({
            :label => 'Work Fax',
            :number => data[20]
          })
        end

        unless data[21].blank?
          member.email_addresses.create({
            :address => data[21]
          })
        end

        # Qualifications

      end
    end
  end
end
