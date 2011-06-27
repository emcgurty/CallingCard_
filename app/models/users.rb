class Users < ActiveRecord::Base

#set_primary_key :uuid
 #include UUIDHelper

 
 ObsceneWords = %w{} 
 email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 name_alpha_regex = /\A[ a-zA-Z'-]+\z/
 alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
 alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."
 alpha_numeric_regex = /\A[ a-zA-Z0-9!?.:;'-]+\z/

#attr :password
#attr_protected :password
#attr :password_confirmation
#attr_protected :password_confirmation

 validates_presence_of :username, :on => 'create', :message => "is a required field."
 validates_length_of :username, :on => 'create', :in => 6..16, :message => "must be between 6 and 16 characters"
 validates_uniqueness_of :username, :on => 'create', :message => "is already being used."

 validates_presence_of :password, :on => 'create', :message => "is a required field."
 validates_length_of :password, :on => 'create', :in => 6..16, :message => "must be between 6 and 16 characters"
 validates_presence_of :password_confirmation, :if => :password_changed?
 validates_confirmation_of :password  #,  :if => :password.equal?(:password_confirmation),  :on => 'create', :message => "password and re-entered password must match."



 validates_length_of :email,   :maximum => 50, :on => 'create', :message => "is too many characters."
 validates_format_of  :email,       :on => 'create', :with => email_regex, :message => "improperly formatted"
 validates_format_of :email, :without => /NOSPAM/, :message=> "can't include SPAM links."
   
 validates_presence_of :first_name, :on => 'create', :message => "is a required field."
 validates_format_of :first_name,   :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg
 validates_length_of :first_name, :maximum => 15, :on => 'create', :message => "is too many characters."

 validates_length_of :MI, :is => 1, :allow_blank => true, :on => 'create', :message => "is not a valid size."
 validates_format_of :MI,          :allow_blank => true, :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg

 validates_length_of :last_name, :maximum => 15, :on => 'create', :message => "is too many characters."
 validates_presence_of :last_name,  :on => 'create', :message => "is a required field."
 validates_format_of :last_name,    :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg

 validates_format_of  :email, :allow_blank => true,       :on => 'create', :with => email_regex, :message => "improperly formatted"

end
