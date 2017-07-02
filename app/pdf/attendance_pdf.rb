class AttendancePdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 8.25.in, 11.69.in ]
  MARGIN = 0

  def initialize()
    if Rails.env.production?
      bg_img = nil
    else
      bg_img = "#{Rails.root}/private/star-award-blank.png"
    end
    super( :page_size => PAGE_SIZE, :margin => MARGIN, :background => bg_img)
  end

  def to_pdf( params )

    image "#{Rails.root}/public/pna-medalion.png", position: 5.85.in, vposition: 0.35.in, height: 1.75.in

    bounding_box( [ 0.25.in, 10.8.in ], :width => 7.in, :height => 6.in ) do

      bounding_box( [ 0, 6.in ], :width => 4.75.in, :height => 6.in ) do
      font File.join( Rails.root, 'fonts', 'Arial.ttf' )
      font_size 12
      text Date.today.strftime( '%B %d, %Y' )
      move_down 0.25.in
      text "Dear #{params[ :member ].first_name}"

      move_down 0.25.in

      text "Congratulations on having passed your training course. Thousands of paddlers have taken part in BCU programs in North America. Whatever your paddlesports objective, there is something for everyone, which is why paddlesports continues to be the most popular watersport."

      move_down 0.25.in
      text "Information about PNA membership and member benefits can be found on the PNA website at http://www.paddlesportsnorthamerica.org. If you have any questions about the programs we offer, please contact your PNA Regional Representative. You can find your Regional Representative by visiting the Coaches page on PNA's website: http://www.paddlesportsnorthamerica.org/coaches"
      end
    end

    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf' )

    bounding_box( [0.25.in, 3.85.in], :width => bounds.width, :height => 2.in ) do
      font_size 24
      text params[ :award ].name, :align => :center
    end

    font_size 18

    bounding_box( [2.70.in,3.1.in], :width => 3.in, :height => 2.in ) do
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :left
    end

    font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    font_size 8
    bounding_box([ 2.1.in, 1.1.in ], :width => 1.75.in, :height => 40 ) do
      text params[ :date ].strftime( '%B %d, %Y'), :align => :left
    end

    render
  end

end
