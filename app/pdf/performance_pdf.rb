class PerformancePdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 8.in, 11.75.in ]
  MARGIN = 0.40.in

  def to_pdf( params )
    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf' )
    font_size 36

    move_down 6.40.in

    text params[ :award ].gsub( /Star\s/, '' ), :align => :right

    move_down 1.40.in

    font_size 22

    indent( 320 ) do
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :left
    end

    move_down 1.30.in - 10
    font_size 12
    bounding_box([ 400, 78 ], :width => 800, :height => 40 ) do
      text params[ :date ].strftime( '%B %d, %Y'), :align => :left
    end

    bounding_box([ 5, 60 ], :width => 3.in, :height => 50 ) do
      font File.join( Rails.root, 'fonts', 'Arial.ttf' )
      font_size 8
      text "Certificate # #{params[ :member ].id.to_s.rjust(4,'0')}-#{params[:date].strftime('%m%d%y')}-#{params[ :course ].id.to_s.rjust(4, '0')}"
    end

    bounding_box( [ 0.25.in, 10.8.in ], :width => 7.in, :height => 6.in ) do

      bounding_box( [ 0, 6.in ], :width => 4.75.in, :height => 6.in ) do
        font File.join( Rails.root, 'fonts', 'Arial.ttf' )
        font_size 12
        text Date.today.strftime( '%B %d, %Y' )

        move_down 0.25.in

        text "Dear #{params[ :member ].first_name}"

        move_down 0.25.in

        text "Congratulations on having passed your Star Award. Thousands of paddlers have taken part in BCU programs in North America. Whatever your paddlesports objective, there is something for everyone, which is why paddlesports continues to be the most popular watersport."

        unless params[ :member ].addresses.empty?
          move_down 0.25.in
          font_size 16
          indent( 0.25.in) do
            text "#{params[ :member ].first_name} #{params[ :member ].last_name}"
            text params[ :member ].addresses.first.address1
            text params[ :member ].addresses.first.address2 unless params[ :member ].addresses.first.address2.nil?
            text "#{params[ :member ].addresses.first.city}, #{params[ :member ].addresses.first.state.abbr} #{params[ :member ].addresses.first.postal_code}"
            text params[ :member ].addresses.first.country.iso3
          end
          font_size 12
          move_down 0.25.in
        end

        text "Whatever type of paddling you enjoy, BCU membership offers a variety of benefits. It's easy to join, just visit www.BCUNA.com to download a membership form."

        move_down 0.25.in

        text "Also visit BCU UK (Canoe England) at www.bcu.org.uk."
      end

      bounding_box( [ 5.in, 6.in ], :width => 2.in, :height => 6.in ) do
        move_down 2.in

        text "BCUNA"
        text "320 W. Saugerties Rd."
        text "Saugerties, NY 12477"
        text "845-246-6817"

        move_down 0.5.in

        text "Cane England"
        text "18 Market Place"
        text "Bingham"
        text "Nottingham"
        text "NG13 8AP"
      end

    end

    render
  end

end
