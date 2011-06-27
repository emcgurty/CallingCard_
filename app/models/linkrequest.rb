class Linkrequest < ActiveRecord::Base

   require 'fastimage'
   require 'open-uri' 
   belongs_to                 :country
   belongs_to                 :state
   
 ObsceneWords = %w{} 
 email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 name_alpha_regex = /\A[ a-zA-Z'-]+\z/
 mi_alpha_regex = /\A[a-zA-Z]+\z/
 alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
 alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."

 # downcase only effective in ASCII region 
 ## Validation on length not necessary as done atpresentation level

validates_format_of :image_content_type, :allow_blank=>true,
                      :with => /^image/,
                      :message => "--- you can only upload pictures"

validates_numericality_of :img_height, :allow_blank=>true, :less_than => 101
validates_numericality_of :img_width,  :allow_blank=>true,:less_than => 101

 validates_presence_of :organization_name, :on => 'create', :message => "is a required field."
 validates_format_of :organization_name,   :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg
 validates_uniqueness_of :organization_name, :on => 'create', :message => " has already been offered."
 validates_length_of :mission, :maximum => 100, :on => 'create',  :too_long => "%{count} characters is the maximum allowed for the Organization name."

 validates_presence_of :organization_url, :on => 'create', :message => "is a required field."
 validates_length_of :organization_url,   :maximum => 100, :on => 'create', :too_long => "%{count} characters is the maximum allowed for the Organization url."
 validates_format_of :mission,   :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg
 validates_length_of :mission, :maximum => 255, :on => 'create',  :too_long => "%{count} characters is the maximum allowed for the Organization Mission."

 validates_presence_of :first_name, :on => 'create', :message => "is a required field."
 validates_format_of :last_name,    :on => 'create', :with => name_alpha_regex, :message => "must be a alpha-character, no numbers"
 #validates_exclusion_of :first_name.to_s.downcase, :in => ObsceneWords, :message => ":no obscenity."

 validates_length_of :mi, :is => 1, :on => 'create', :allow_blank => true,        :message => "is not a valid size."
 validates_format_of :mi,           :on => 'create', :allow_blank => true,        :with => mi_alpha_regex, :message => "must be a alpha-character, no numbers"

 validates_length_of :first_name, :maximum => 15, :on => 'create', :message => "is too many characters."
 validates_length_of :last_name, :maximum => 15, :on => 'create', :message => "is too many characters."
 validates_length_of :city, :maximum => 15, :on => 'create', :message => "is too many characters."
 validates_length_of :zip_code, :maximum => 12, :on => 'create', :message => "is too many characters."

 validates_length_of :email,   :maximum => 50, :on => 'create', :message => "is too many characters."
 validates_format_of  :email,       :on => 'create', :with => email_regex, :message => "improperly formatted"
 validates_format_of :email, :without => /NOSPAM/, :message=> "can't include SPAM links."
 #validates_exclusion_of :last_name.downcase, :in => ObsceneWords, :message => ":no obscenity."
 validates_presence_of :last_name,  :on => 'create', :message => "is a required field."
 validates_format_of :last_name,    :on => 'create', :with => name_alpha_regex, :message => "must be a alpha-character, no numbers"
 

 validates_presence_of :city,       :on => 'create', :message => "is a required field."
 #validates_exclusion_of :city.downcase,     :in => ObsceneWords, :message => ":no obscenity."
 validates_format_of :city,         :on => 'create', :with =>  alpha_numeric_regex , :message => "must be alphanumeric characters"

 


  def uploaded_picture=(picture_field)

  # .basename -- doesn't work
    name =   base_part_of(picture_field.original_filename)
    directory = "public/client"
    # create the file path
    path = File.join(directory, name)
    # write the file -- b is for binary
    File.open(path, "wb") { |f| f.write(picture_field.read) }
   
    
    self.image_file_name         =  base_part_of(picture_field.original_filename)
    self.image_content_type = picture_field.content_type.chomp
    

    myArray          = FastImage.size(path)
    self.img_height  = myArray[1].to_s
    self.img_width   = myArray[0].to_s
   
    
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end



end
