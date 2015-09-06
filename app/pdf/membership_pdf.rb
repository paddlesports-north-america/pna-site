class MembershipPdf < Prawn::Document

  require "prawn/measurement_extensions"

  PAGE_SIZE = Prawn::Document::PageGeometry::SIZES["LETTER"]
  TEMPLATES = {
                :header => File.join( Rails.root, 'private', 'pna-membership-header-bw.png' ),
                :card => File.join( Rails.root, 'private', 'pna-charter-member-card-bw.png')
              }
  MARGIN = -0.5.in

  FONT_WEIGHT = {
    :bold => File.join( Rails.root, 'fonts', 'Arial Bold.ttf'),
    :regular => File.join( Rails.root, 'fonts', 'HelveticaNeue.ttf' ),
    :lead => File.join( Rails.root, 'fonts', 'HelveticaNeueLight.ttf')
  }

  COPY = {
    :lead => 'Thank you, for your membership.',
    :body => [
      'The organization serves to expand knowledge and awareness of all paddlesport-related activities - canoe, kayak and stand up paddleboard - and encourages lifetime participation in the sport through delivery of long-term paddler development programs. Paddlesports North America (PNA) provides classroom education and on-water training through a series of paddlesport modules developed and continually refined by British Canoeing (BCU). The British Canoeing program is internationally recognized as the gold standard in paddlesport training. PNA coaches and invited guest British Canoeing coaches deliver paddler and coach trainings and assessments throughout North America. The organization develops, encourages, trains and supports coaches to deliver these programs, and maintains all personal achievement records. PNA encourages people of all ages and abilities to go paddling, stressing personal safety and respect for the environment. PNA is a not-for-profit, educational, public charity formed to deliver British Canoeing programs throughout North America, and is exempt from Federal income tax under section 501(c)3 of the Internal Revenue Code.',
      'For more information on upcoming courses please check out our website at: http://www.paddlesportsnorthamerica.org/calendar',
      'Your membership qualifies you as an ambassador for PNA. Please spread the word about PNA courses and help us recruit new members!'
    ]
  }
  
  COLOR = '4C4D4F'

  def to_pdf( membership )

    image TEMPLATES[ :header ], :at => [ 0.86.in, PAGE_SIZE[1] - 0.5625.in ], :fit => [ PAGE_SIZE[ 0 ] - 0.86.in * 2, PAGE_SIZE[ 1 ] - 1.14.in ]
    
    
    bounding_box( [ 1.1.in, PAGE_SIZE[1] - 1.9.in ], :width => PAGE_SIZE[0] - 2.2.in ) do
      
      make_font :lead, 21
      text COPY[ :lead ], :align => :center, :color => COLOR
      
      move_down 0.25.in
      make_font :regular, 13
      COPY[ :body ].each do |c|
        text c, :align => :justify, :color => COLOR
        move_down 0.15.in
      end
    end
    image TEMPLATES[ :card ], :at => [ 0.86.in, PAGE_SIZE[1] - 8.17.in ], :fit => [ PAGE_SIZE[ 0 ] - 0.86.in * 2, PAGE_SIZE[ 1 ] - 1.14.in ]
    
  # Member Info
    bounding_box( [ 4.5.in, 2.5.in ], :width => 2.86.in, :height => 1.61.in ) do
      make_font :regular, 18
      text "#{membership.type} Member", :align => :center, :color => COLOR
      
      move_down 0.26.in
      make_font :regular, 10
      text "#{membership.member.first_name} #{membership.member.last_name}", :align => :center, :color => COLOR
      
      # move_down 0.05.in
      text "Valid Until #{membership.expiration_date.strftime( "%m/%d/%Y" )}", :align => :center, :color => COLOR
      
      move_down 0.15.in
      make_font :regular, 24
      text sprintf( "%06d", membership.member.id ), :align => :center, :color => COLOR
    end
  #END member info
    
    

    render
  end

  def make_font( weight, size )
    font FONT_WEIGHT[ weight ]
    font_size size
  end
end
