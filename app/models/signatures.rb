class Signatures < ActiveRecord::Base

 ObsceneWords = %w{} 
 email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 alpha_regex = /\A[ a-zA-Z'-]+\z/
 alpha_numeric_regex = /\A[ a-zA-Z0-9!?.:;'-]+\z/
 # downcase only effective in ASCII region 
 

 validates_presence_of :first_name, :on => 'create', :message => "is a required field."
 validates_format_of :first_name,   :on => 'create', :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"
# validates_exclusion_of :first_name.to_s.downcase, :in => ObsceneWords, :message => ":no obscenity."
 validates_length_of :first_name, :maximum => 15, :on => 'create', :message => "is too many characters."

 validates_length_of :mi, :is => 1, :allow_blank => true, :on => 'create', :message => "is not a valid size."
 validates_format_of :mi,          :allow_blank => true, :on => 'create', :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"

 validates_length_of :last_name, :maximum => 15, :on => 'create', :message => "is too many characters."
# validates_exclusion_of :last_name.downcase, :in => ObsceneWords, :message => ":no obscenity."
 validates_presence_of :last_name,  :on => 'create', :message => "is a required field."
 validates_format_of :last_name,    :on => 'create', :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"

# validates_exclusion_of :alias.downcase, :in => ObsceneWords, :on => 'create', :message => "No obscenity."
 validates_length_of :alias, :on => 'create', :in => 6..16, :message => "must be between 6 and 16 characters"
 validates_uniqueness_of :alias, :on => 'create', :message => "is already being used."
 validates_uniqueness_of :alias, :scope=> [:first_name, :mi, :last_name] ,   :on => 'create', :message => "for the given name, the provided alias is already taken."
 
 validates_presence_of :YOB,  :on => 'create', :message => ", as presented here as 'Year of Birth' is a required field."


 validates_length_of :city, :maximum => 15, :on => 'create', :message => "is too many characters."
 validates_length_of :postal_code, :maximum => 12, :on => 'create', :message => "has a character limited of 12."
 

 
 validates_format_of  :email, :allow_blank => true,       :on => 'create', :with => email_regex, :message => "improperly formatted"
  validates_presence_of :email, :if => Proc.new { |a| not a.comments.blank? },  :on => 'create', :message => "is required in offering comments."


 validates_length_of :comments, :maximum => 255, :allow_blank => true, :on => 'create', :message => "permits 255 character, spaces are included in the count."
 validates_format_of :comments,    :on => 'create', :allow_blank => true, :with => alpha_numeric_regex, :message => "must contain only alphanumeric characters with typical punctuation"


 validates_presence_of :signature_agreement, :is => 1,  
:on => 'create', 
:message => ": you are required to attest that you are a responsible and earnest person."



 validates_presence_of :address1,   :on => 'create', :message => "is a required field."

# validates_exclusion_of :address1.downcase, :in => ObsceneWords, :message => ":no obscenity."
# validates_exclusion_of :address2.downcase, :in => ObsceneWords, :message => ":no obscenity."

 validates_presence_of :city,       :on => 'create', :message => "is a required field."
# validates_exclusion_of :city.downcase,     :in => ObsceneWords, :message => ":no obscenity."
 validates_format_of :city,         :on => 'create', :with => alpha_regex , :message => "must be an alpha-character, no numbers"


end


=begin
GUID's are quite common with legacy Database system. A GUID or a Globally Unique Identifier, is used as unique reference and can be used a primary key. here is an example of a Guid : {5ED7E810-F1DC-11DD-A929-00215A453F2E}

Ruby on rails by default likes to work with primary key that are auto incremented each time a new record is inserted e.g. 1,2,3,4 and so on. However, if you are working with a table that requires a guid as a primary key, carry out the following

    First install the gem uuidtools (gem install uuidtools )
    Create a uuid_helper.rb file and place it in the Helpers folder of your ROR application

Following is the code for uuid_helper.rb

require 'rubygems'
require 'uuidtools'

module UuidHelper
def before_create
self.id= UUID.timestamp_create().to_s
end
end


The file first includes the installed gems. It defines a module called UuidHelper, this is the name that the other files will be using to access the functionality. In it, there is a before_create method which is executed before a new record is inserted. It replaces the auto incremented id (generated by the system), with a GUID value created using the UUID.timestamp_create method.


In your model file, do the following
class Ampeople < ActiveRecord::Base
include UuidHelper


If you are using associations in your model, then call them first before you include the module, otherwise it does not seem to like it for some reason.

class Ampeople < ActiveRecord::Base

set_table_name 'am_people'
set_primary_key 'people_id'

has_many :friends, : foreign_key =""> 'friend_id'

include UuidHelper

#rest of your code goes here ..... 
=end

