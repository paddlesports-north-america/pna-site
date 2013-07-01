class MembershipPdf < Prawn::Document

  require "prawn/measurement_extensions"

  PAGE_SIZE = [ 5.5.in, 8.5.in ]
  MARGIN = -0.5.in

  FONT_WEIGHT = {
    :bold => File.join( Rails.root, 'fonts', 'Arial Bold.ttf'),
    :regular => File.join( Rails.root, 'fonts', 'Arial.ttf' )
  }

  def to_pdf( membership )

    move_up 0.25.in

    make_font :regular, 18
    # font File.join( Rails.root, 'fonts', 'Arial.ttf' )
    # font_size 18

    text "Temporary BCU Membership Card", :align => :center

    move_down 0.365.in

    text "This is to certify that", :align => :center

    move_down 0.125.in

    make_font :bold, 24
    text "#{membership.member.first_name} #{membership.member.last_name}", :align => :center

    move_down 0.35.in

    make_font :regular, 18
    text "has paid for a", :align => :center
    text "BCU #{membership.membership_type.name.humanize} Membership", :align => :center

    move_down 0.15.in
    image "#{Rails.root}/public/bw-logo.png", :position => 1.3.in, height: 2.25.in

    move_down 0.255.in
    text "The official BCU membership card will be sent directly from the BCU. This temporary card is valid for ninety days from the date listed below.", :align => :center

    make_font :regular, 12

    move_down 0.8.in

    indent( 1.in ) {
      text "Bill Lozano"
      text "US North American Administrator"
    }

    move_down 0.1.in
    stroke_horizontal_rule
    move_down 0.1.in
    text membership.created_at.strftime("%B %d, %Y")
    move_up 14
    text "Number: #{membership.member.id}", :align => :right

    render
  end

  def make_font( weight, size )
    font FONT_WEIGHT[ weight ]
    font_size size
  end
end
