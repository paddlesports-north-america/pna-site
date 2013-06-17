class MembershipPdf < Prawn::Document

  require "prawn/measurement_extensions"

  PAGE_SIZE = [ 5.5.in, 8.5.in ]
  MARGIN = 0.5.in

  def to_pdf( membership )
    font File.join( Rails.root, 'fonts', 'Arial Bold.ttf')
    font_size 24

    move_down 1.in
    text "#{membership.member.first_name} #{membership.member.last_name}", :align => :center

    move_down 5.95.in
    font File.join( Rails.root, 'fonts/Arial.ttf' )
    font_size 12
    text membership.created_at.strftime("%B %d, %Y")
    move_up 14
    text "Number: #{membership.member.id}", :align => :right

    render
  end
end
