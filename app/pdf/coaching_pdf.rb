class CoachingPdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 6.in, 8.5.in ]
  MARGIN = 0

  def to_pdf( params )

    bounding_box( [ 0, 5.85.in ], :width => 6.in, :height => 1.5.in ) do
      font_size 26
      text params[ :award ], :align => :center
    end

    bounding_box( [ 0, 4.25.in ], :width => 6.in, :height => 1.in ) do
      font_size 24
      text "#{params[ :member ].first_name} #{params[ :member ].last_name}", :align => :center
    end

    bounding_box( [ 0.25.in, 2.85.in ], :width => 2.45.in, :height => 1.in ) do
      font_size 12
      text params[ :date ].strftime( '%B %d, %Y' ), :align => :center
    end

    bounding_box( [ 2.85.in, 2.85.in ], :width => 2.45.in, :height => 1.in ) do
      text "#{params[ :member ].id.to_s.rjust( 4, '0' )}#{params[:course].id.to_s.rjust(4,'0')}", :align => :center, :character_spacing => 1.25
    end
    render
  end

end
