class ContactController < ApplicationController
  def index
    if request.post?
      @message = Message.new( params[ :message ] )
      if @message.valid?
        ContactMailer.contact_email( @message ).deliver
        @notice = "Your message has been sent! We'll get back to you as soon as we can."
        # redirect_to '/contact'
        @message = Message.new
      else
        @notice = "We are having trouble sending your message"
      end
    else
      @message = Message.new
    end
  end

  def thank_you
  end
end
