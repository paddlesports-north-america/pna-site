class AttendancePdf < Prawn::Document

  require 'prawn/measurement_extensions'

  PAGE_SIZE = [ 8.25.in, 11.69.in ]
  MARGIN = 0

  def initialize()
    if Rails.env.production?
      bg_img = nil
    else
      bg_img = "#{Rails.root}/private/attendance-certificate-blank.png"
    end
    super( :page_size => PAGE_SIZE, :margin => MARGIN, :background => bg_img)
  end

  def to_pdf( params )

    bounding_box( [ 0.25.in, 10.8.in ], :width => 6.25.in, :height => 6.in ) do
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

    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf' )

    bounding_box( [ 0.in,3.125.in ], :width => 8.25.in, :height => 3.in ) do
      font_size 24
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :center
    end

    bounding_box( [ 0, 2.125.in ], :width => 8.25.in, :height => 2.in ) do
      font_size 28
      text params[ :award ].name, :align => :center
    end

    font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    bounding_box( [ 0, 1.5.in ], :width => 8.25.in, :height => 1.in ) do
      font_size 12
      text params[ :date ].strftime( '%B %d, %Y' ), :align => :center
    end

    render
  end

end
