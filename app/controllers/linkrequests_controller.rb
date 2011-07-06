class LinkrequestsController < ApplicationController

require 'fastimage'
require 'open-uri'
before_filter :login_required

def sendmail
    do_sendmail 
end

def displayAllListingsGrid
     @linkrequests = Linkrequests.find(:all, :readonly=>true)
	 respond_to do |format|
      	format.html 
       end
end

def destroy
  destroy_this
end

def new
      @linkrequests = Linkrequests.new
      myState = 'Virginia'
      @state = State.find(:first, :conditions => ['state = ?', myState])
      @linkrequests.state_id = @state[:id]
      myCountry = 'United States'
      @country = Country.find(:first, :conditions => ['country = ?', myCountry])
      @linkrequests.country_id  = @country[:id]      

end

def show
    begin
    myid = params[:uuid]
    rescue Exception => msg
	render :text => 'Error occurred in sending uuid' + '.  Specifically, error: ' + msg.message  
    end

    @linkrequests = Linkrequests.find(:first, :conditions => ['uuid = ?', myid], :readonly=>true)
     respond_to do |format|
       format.html # index.html.erb
     end
end



def create
  do_create
end

def displayPicture
  display_select_picture
end

protected

def destroy_this
	 begin
        myID = params[:uuid]
        Linkrequests.find(:first, :conditions => ['uuid = ?', myID]).destroy
        redirect_to :controller=>'home', :action=>'show'
      rescue Exception => msg
	  flash[:notice] = 'Error occurred in deleting link request.  Specifically, error: ' + msg.message 
        redirect_to :controller=>'home', :action=>'errorpage'
       end
      
     
      rescue ActiveRecord::RecordNotFound
         flash[:notice]  = "Record not found in 'Changed My Mind' link request function"
         redirect_to :controller=>'home', :action=>'show', :id=>'errorpage'
      rescue ActiveRecord::ActiveRecordError
         flash[:notice] = "Active Record Error in 'Changed My Mind' link request function"
         redirect_to :controller=>'home', :action=>'show', :id=>'errorpage'
end

def do_create
   @linkrequests = Linkrequests.new(params[:linkrequests])
     
         if @linkrequests.save
           render  :action => 'show', :uuid => @linkrequests.uuid 
         else
           render :action => 'new'
         end
end


def display_select_picture
   myID = params[:uuid]
   @linkrequests = Linkrequests.find(:first, :conditions => ['uuid = ?', myID])
   
   if (not @linkrequests.blank?)
   	path = File.join("public/client", @linkrequests.image_file_name)
	# write the file

	##IO.read

	   ## both example send the picture distorted, corrected by adding "b"
	   #send_data(IO.read(path), 
	   #            :filename => @linkrequests.image_file_name,
	   #            :type => @linkrequests.image_content_type,
	   #            :disposition => "inline")
	   File.open(path, 'rb') do |f|
                send_data(f.read, 
               :filename => @linkrequests.image_file_name,
               :type => @linkrequests.image_content_type,
               :disposition => "inline")
         end
      else
         flash[:notice] = "Error in retrieving link request pictures."
      end 

   

   #Tip: if you want to stream large amounts of on-the-fly generated data to the browser, 
   #then use render :text => proc { ... } instead. See ActionController::Base#render for more information.

end

def do_sendmail
	
            begin
            myID = params[:uuid]
            @linkrequests = Linkrequests.find(:first, :conditions => ['uuid = ?', myID])
            rescue Exception => msg
		   	flash[:notice] = 'Could not get link request record in Sendmail'  + msg.message
            end

            
            if ( not @linkrequests.blank?)
			
                  begin
                  recipient = @linkrequests.email
		      subject = 'Thanks for offering your link'
		      message = ''
      		body = {:first_name => @linkrequests.first_name, 
				  :last_name => @linkrequests.last_name,
				  :mi => @linkrequests.mi,
				  :mission => @linkrequests.mission,
                          :url => @linkrequests.organization_url, 
                          :guest_name => @linkrequests.organization_name} 
		      myemail = Notifier.contact(recipient, subject, message, body)
 		      myemail.deliver
			flash[:notice] = 'Message successfully sent to '  + recipient + '.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
                  rescue Exception => msg
		      	flash[:notice] = 'Error occurred in sending Link Request email.  Specifically, error: ' + msg.message  
                        redirect_to :controller=>'home', :action=>'show', :id=>'errorpage'
                  end
		      
		else
                  flash[:notice] = 'Message not successfully sent.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'errorpage'
		end
end

end
