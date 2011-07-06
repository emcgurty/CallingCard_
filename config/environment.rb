# Load the rails application
require File.expand_path('../application', __FILE__)

##  emm added next three lines
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION
#ENV['RAILS_ENV'] = 'production'
ENV['RAILS_ENV'] = 'development'

if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/USERNAME/.gems' + ':/usr/lib/ruby/gems/1.8'
end

if rails_env = ENV['RAILS_ENV']
  require 'logger'
  logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = logger
  ActiveResource::Base.logger = logger
  Rails.logger = logger
end
 
require File.join(File.dirname(__FILE__), 'boot')

# Initialize the rails application
Banumva::Application.initialize!

