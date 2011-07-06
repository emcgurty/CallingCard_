class Notifier < ActionMailer::Base

  default :charset => "utf-8"
  default :content_type => "text/html"
  ## Default :from doesn't always works

def contact(recipient, subject, message, body, sent_at = Time.now)
     do_contact(recipient, subject, message, body, sent_at = Time.now)

   end

def signature_comments(recipient, subject, message, body, sent_at = Time.now)
      do_contact(recipient, subject, message, body, sent_at = Time.now)

   end


def comments_received(recipient, subject, message, body, sent_at = Time.now)
	do_contact(recipient, subject, message, body, sent_at = Time.now)

   end


  def signup_notification(users)
    setup_email(users)
    @subject    += ' Please activate your new account'
    @body[:url]  = "http://#{SITE_URL}/activate/#{users.activation_code}"
   end
 
  def activation(users)
    setup_email(users)
    @subject    += ' Your account has been activated!'
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  def reset_notification(users)
    setup_email(users)
    @subject    += ' Link to reset your password'
    @body[:url]  = "http://#{SITE_URL}/reset/#{users.reset_code}"
  end
  #19
  protected
    def setup_email(users)
      @recipients  = "#{users.email}"
      @from        = ""
      @subject     = SITE_URL
      @sent_on     = Time.now
      @body[:users] = users

    end

   private

   def do_contact(recipient, subject, message, body, sent_at = Time.now)

      @subject = subject
      @recipients = recipient
      @from = ''
      @message = message
      @sent_on = sent_at
      @body = body
      #@headers = {}

end

end
