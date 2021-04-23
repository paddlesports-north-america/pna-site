class ContactMailer < ActionMailer::Base
  default to: 'info@paddlesportsnorthamerica.org' #ENV[ 'CONTACT_MAIL_TO' ]

  def contact_email( message )
    @message = message
    mail( :from => @message.email, :subject => 'Message from PNA Contact Form' )
  end
end
