class Perspectives < ActiveRecord::Base
  
 ObsceneWords = %w{} 
 email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 name_alpha_regex = /\A[ a-zA-Z'-]+\z/
 alias_alpha_regex = /\A[ a-zA-Z0-9]+\z/
 mi_alpha_regex = /\A[a-zA-Z]+\z/
 alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
 alpha_numeric_regex_msg = "must be alphanumeric characters with typical punctuation."
 
 # downcase only effective in ASCII region 
 ## Validation on length not necessary as done at presentation level, but whoops doesn't always work!

# validates_exclusion_of :alias.downcase, :in => ObsceneWords, :on => 'create', :message => "No obscenity."
 validates_length_of :alias, :on => 'create', :in => 6..16, :message => "must be between 6 and 16 characters"
 validates_uniqueness_of :alias, :on => 'create', :message => "is already being used."
 validates_format_of  :alias, :on => 'create', :with => alias_alpha_regex, :message => "must contain only alphanumeric characters"

 validates_format_of  :email, :on => 'create', :with => email_regex, :message => "is improperly formatted"
 validates_presence_of :email,  :on => 'create', :message => "is required."
 validates_presence_of :email, :if => Proc.new { |a| not a.comments.blank? },  :on => 'create', :message => "is required in offering comments."
 validates_length_of :email,   :maximum => 50, :on => 'create', :message => "has too many characters."
 validates_format_of :email, :without => /NOSPAM/, :message=> "can't include SPAM links."

 validates_presence_of :comments,  :on => 'create', :message => "are required."
 validates_length_of :comments, :maximum => 255,  :on => 'create', :message => " has a limit of 255 characters, spaces are included in the count."
 validates_format_of :comments,   :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg
  
end    
