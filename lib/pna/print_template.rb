class Pna::PrintTemplate
  COACHING = 'coaching'
  ENDORSEMENT = 'endorsement'
  PERFORMANCE = 'performance'
  MEMBERSHIP = 'membership'
  ALL = [COACHING, ENDORSEMENT, PERFORMANCE, MEMBERSHIP]

  def self.getTemplate( type )
    if ALL.include? type
      "#{type.humanize}Pdf".constantize
    else
      raise "Invalid Template Type ( #{type} )"
    end
  end

  def self.getPdf( type, args )
    self.getTemplate( type ).new.to_pdf( args )
  end

end