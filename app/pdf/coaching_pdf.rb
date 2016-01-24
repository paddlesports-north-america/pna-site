class CoachingPdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 5.75.in, 8.25.in ]
  MARGIN = 0

  def initialize()
    super( :page_size => PAGE_SIZE, :margin => MARGIN )
  end

  def to_pdf( params )

    bounding_box( [ 0, 5.75.in ], :width => PAGE_SIZE[0], :height => 1.5.in ) do
      font_size 26
      text params[ :award ], :align => :center
    end

    bounding_box( [ 0, 4.125.in ], :width => PAGE_SIZE[0], :height => 1.in ) do
      font_size 24
      text "#{params[ :member ].first_name} #{params[ :member ].last_name}", :align => :center
    end

    bounding_box( [ 0.75.in, 2.85.in ], :width => 1.5.in, :height => 1.in ) do
      font_size 12
      text params[ :date ].strftime( '%B %d, %Y' ), :align => :center
    end

    bounding_box( [ 2.875.in, 2.85.in ], :width => 2.25.in, :height => 1.in ) do
      text "#{params[ :member ].id.to_s.rjust( 4, '0' )}#{params[:course].id.to_s.rjust(4,'0')}", :align => :center, :character_spacing => 1.25
    end
    render
  end

end
