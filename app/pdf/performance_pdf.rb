class PerformancePdf < Prawn::Document

  require 'prawn/measurement_extensions'
  include ActionView::Helpers::TranslationHelper

  PAGE_SIZE = [ 8.25.in, 11.625.in ]
  MARGIN = 0.in

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

        text "Congratulations on having passed your Star Award. Thousands of paddlers have taken part in BCU programs in North America. Whatever your paddlesports objective, there is something for everyone, which is why paddlesports continues to be the most popular watersport."

        unless params[ :member ].addresses.empty?
          move_down 0.25.in
          font_size 16
          indent( 0.25.in) do
            text "#{params[ :member ].first_name} #{params[ :member ].last_name}"
            text params[ :member ].addresses.first.address1
            text params[ :member ].addresses.first.address2 unless params[ :member ].addresses.first.address2.nil?
            text "#{params[ :member ].addresses.first.city}#{", " + params[ :member ].addresses.first.state.abbr if params[ :member ].addresses.first.state} #{params[ :member ].addresses.first.postal_code if params[ :member ].addresses.first.postal_code}"
            text params[ :member ].addresses.first.country.name
          end
          font_size 12
          move_down 0.25.in
        end

        text "Whatever type of paddling you enjoy, PNA membership offers a variety of benefits."
        move_down 0.25.in
        text "It's easy to join, just visit www.PaddlesportsNorthAmerica.org to download a membership form."

        # move_down 0.25.in

        # text "Also visit BCU UK (Canoe England) at www.bcu.org.uk."
      end

      bounding_box( [ 5.5.in, 6.in ], :width => 2.in, :height => 6.in ) do
        move_down 2.in
        font_size 11
        text t('pna.contact.name')
        text t('pna.contact.addr_1')
        text t('pna.contact.addr_2')
        text t('pna.contact.phone.pna')
      end

    end

    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf' )
    font_size 36


    bounding_box( [0.25.in, 3.85.in], :width => bounds.width, :height => 2.in ) do
      font_size 24
      text params[ :award ], :align => :center
    end

    # move_down 1.40.in

    font_size 18

    bounding_box( [2.60.in,3.1.in], :width => 3.in, :height => 2.in ) do
      text "#{params[ :member ].first_name} #{params[ :member ].last_name }", :align => :left
    end

    # move_down 1.30.in - 10
    font_size 8
    bounding_box([ 2.in, 1.10.in ], :width => 1.75.in, :height => 40 ) do
      text params[ :date ].strftime( '%B %d, %Y'), :align => :left
    end

    # bounding_box([ 0.625.in, 1.4.in ], :width => 3.in, :height => 50 ) do
    #   font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    #   font_size 8
    #   text "Certificate # #{params[ :member ].id.to_s.rjust(4,'0')}-#{params[:date].strftime('%m%d%y')}-#{params[ :course ].id.to_s.rjust(4, '0')}"
    # end

    render
  end

end
