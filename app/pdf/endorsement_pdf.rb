class EndorsementPdf < Prawn::Document

  require 'prawn/measurement_extensions'

  # PAGE_SIZE = [ 6.in, 8.25.in ]
  PAGE_SIZE = [ 8.25.in, 11.69.in ]
  MARGIN = 0

  def initialize()
    super( :page_size => PAGE_SIZE, :margin => MARGIN )
  end

  def to_pdf( params )

    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf' )

    bounding_box( [ 0.in,3.125.in ], :width => 8.25.in, :height => 3.in ) do
      font_size 24
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :center
    end

    bounding_box( [ 0, 2.125.in ], :width => 8.25.in, :height => 2.in ) do
      font_size 28
      text params[ :award ], :align => :center
    end

    font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    bounding_box( [ 0, 1.5.in ], :width => 8.25.in, :height => 1.in ) do
      font_size 12
      text params[ :date ].strftime( '%B %d, %Y' ), :align => :center
    end

    bounding_box( [ 6.in, 0.75.in ], :width => 2.25.in, :height => 1.in ) do
      text "#{params[ :member ].id.to_s.rjust( 4, '0' )}#{params[:course].id.to_s.rjust(4,'0')}", :align => :center, :character_spacing => 1.25
    end
    render
  end

end
