Banumva::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = false
  DISPLAY_ROWS = 10
  DISPLAY_TEXT = 'ten'
  SITE_URL = "localhost:3000"

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false
   #config.middleware.clear
  config.active_record.observers
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
config.log_level = :info
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
		:enable_starttls_auto => true,
            :address => "smtp.gmail.com" ,
		:port => 587,
  		:domain => "gmail.com",
      	:authentication => :plain,
		:user_name =>  "@gmail.com",		
		:password =>  ""
}

#config.action_mailer.default_charset = "utf-8"
#config.action_mailer.default_content_type = "text/html"


  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  #config.whiny_nils = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

#config.gem "simple_navigation",     :lib => "simple_navigation",     :source => "http://gems.github.com"
#Rails::Initializer.run do |config|
 
#  config.gem "fastimage", :lib=>"fastimage"
 
#end
end

