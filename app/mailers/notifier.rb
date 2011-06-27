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

def school(recipient, subject, message, body, sent_at = Time.now)
	do_contact(recipient, subject, message, body, sent_at = Time.now)

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
