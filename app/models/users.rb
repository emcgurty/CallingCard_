require 'digest/sha1'
class Users < ActiveRecord::Base
  ## Source: http://net.tutsplus.com/tutorials/ruby/getting-started-with-restful-authentication-in-rails/

 has_many  :perspectives
 has_many  :linkrequest


 ObsceneWords = %w{} 
 email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 name_alpha_regex = /\A[ a-zA-Z'-]+\z/
 alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
 alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."
 alpha_numeric_regex = /\A[ a-zA-Z0-9!?.:;'-]+\z/
# Virtual attribute for the unencrypted password
  attr_accessor :password

  

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
 validates_presence_of     :login, :email
 validates_presence_of     :password,                   :if => :password_required?
 validates_presence_of     :password_confirmation,      :if => :password_required?
 validates_length_of       :password, :within => 6..40, :if => :password_required?,  :message => "must be between 6 and 40 characters"
 validates_confirmation_of :password,                   :if => :password_required?
 validates_length_of       :login,    :within => 6..40,                              :message => "must be between 6 and 40 characters"

 validates_length_of       :email,    :within => 6..100
 validates_uniqueness_of   :login, :email, :case_sensitive => false
 before_save :encrypt_password
 before_create :make_activation_code 
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :reset_code, :first_name, :last_name, :MI, :username
  
  

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end
  
  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  #reset methods
  def create_reset_code
    @reset = true
    self.attributes = {:reset_code => Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )}
    save(false)
  end

  def recently_reset?
    @reset
  end

  def delete_reset_code
    self.attributes = {:reset_code => nil}
    save(false)
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
    
end
