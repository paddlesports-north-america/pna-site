namespace :import do

  def current_admin_user
    AdminUser.first
  end

  def parse_file( path, &block )
    require 'CSV'

    File.open( path, 'r').each_with_index do |line,index|
      next if index == 0
      CSV.parse( line ) do |data|
        begin
          block.call( data )
        rescue Exception => e
          puts "Failed on line #{index}"
          puts data.inspect
          puts e.message
          puts e.backtrace
        end
      end
    end
  end

  task :test, [ :path ] => :environment do |t,args|
    parse_file args[ :path ] do |d|
      puts d.inspect
    end
  end

  desc "import product data"
  task :products, [ :path ] => :environment do |t,args|
    parse_file args[ :path ] do |data|
      fee = Product.new
      fee.id        = data[0]
      fee.amount    = data[2]
      fee.category  = data[5]

      desc = data[1]
      desc = desc.gsub(/([0-9])\*T/, '\1 Star Training')
      desc = desc.gsub(/([0-9])\*/, '\1 Star')
      desc = desc.gsub(/L([0-9])/, 'Level \1')
      desc = desc.gsub(/WW/, 'White Water')
      desc = desc.gsub(/MWE/, 'Moderate Water Endorsement')

      fee.description = desc
      fee.save!
    end
  end

  desc "Imports member data from csv"
  task :members, [ :path ] => :environment do |t,args|
    ActiveRecord::Base.transaction do
      parse_file args[ :path ] do |data|
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

        unless data[39].blank? || data[40].blank?
          member.first_aid_certifications.create({
            :certification_level => FirstAidCertification::LEVEL[ :other ],
            :certification_type => FirstAidCertification::TYPE[ :first_aid ],
            :provider => data[39],
            :expiration_date => data[40] #Date.strptime( data[40], '%m/%d/%y' )
          })
        end

        unless data[41].blank? || data[42].blank?
          member.first_aid_certifications.create({
            :certification_level => FirstAidCertification::LEVEL[ :other ],
            :certification_type => FirstAidCertification::TYPE[ :cpr ],
            :provider => data[41],
            :expiration_date => data[42] #Date.strptime( data[42], '%m/%d/%y' )
          })
        end

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

      end
    end
    # reset sequence tables so we don't have problems later
    # This is a postgres issue, unfortunately
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    # Set version information
    Version.all.each{ |v| v.update_attributes( :whodunnit => '1' ) }
  end # end of members

end # end of namespace
