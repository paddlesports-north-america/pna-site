class EndorsementPdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 5.5.in, 8.in ]
  MARGIN = 0

  def initialize()
    if Rails.env.production?
      bg_img = nil
    else
      bg_img = "#{Rails.root}/private/moderate-water-blank.png"
    end
    super( :page_size => PAGE_SIZE, :margin => MARGIN, :background => bg_img)
  end

  def to_pdf( params )

    font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    bounding_box( [ 0.in, 5.35.in ], :width => 5.5.in, :height => 3.in ) do
      font_size 18
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :center
    end

    bounding_box( [ 0, 4.3.in ], :width => 5.5.in, :height => 2.in ) do
      font_size 18
      text params[ :award ].name, :align => :center
    end


    bounding_box( [ 0.4.in, 3.in ], :width => 5.5.in, :height => 1.in ) do
      font_size 10
      text params[ :date ].strftime( '%B %d, %Y' )
    end

    bounding_box([ 3.5.in, 3.in ], :width => 5.5.in, :height => 1.in ) do
      font_size 10
      text "#{params[ :member ].id.to_s.rjust(4,'0')}-#{params[:date].strftime('%m%d%y')}-#{params[ :award ].id.to_s.rjust(4, '0')}"
    end

    render
  end

end
