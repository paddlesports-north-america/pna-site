class EndorsementPdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 6.in, 8.25.in ]
  MARGIN = 0

  def to_pdf( params )

    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf' )

    bounding_box( [ 0,5.6.in ], :width => 6.in, :height => 3.in ) do
      font_size 24
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :center
    end

    bounding_box( [ 0, 4.5.in ], :width => 6.in, :height => 2.in ) do
      font_size 16
      text params[ :award ], :align => :center
    end

    font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    bounding_box( [ 0, 3.20.in ], :width => 2.25.in, :height => 1.in ) do
      font_size 10
      text params[ :date ].strftime( '%B %d, %Y' ), :align => :center
    end

    bounding_box( [ 3.1.in, 3.20.in ], :width => 2.25.in, :height => 1.in ) do
      text "ABCD1234", :align => :center, :character_spacing => 1.25
    end
    render
  end

end
