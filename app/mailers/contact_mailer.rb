class ContactMailer < ActionMailer::Base
  default to: 'salbanese0080@gmail.com' #ENV[ 'CONTACT_MAIL_TO' ]

  def contact_email( message )
    @message = message
    mail( :from => @message.email, :subject => 'Message from PNA Contact Form' )
  end
end
