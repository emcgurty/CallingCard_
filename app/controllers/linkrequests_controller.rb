class LinkrequestsController < ApplicationController

require 'fastimage'
require 'open-uri'

def sendmail
    do_sendmail
end

def displayAllListingsGrid
     @linkrequest = Linkrequest.find(:all, :readonly=>true)
	 respond_to do |format|
      	format.html 
       end
end

def destroy
  destroy_this
end

def new
      @linkrequest = Linkrequest.new
      myState = 'Virginia'
      @state = State.find(:first, :conditions => ['state = ?', myState])
      @linkrequest.state_id = @state[:id]
      myCountry = 'United States'
      @country = Country.find(:first, :conditions => ['country = ?', myCountry])
      @linkrequest.country_id  = @country[:id]      

end

def show
  @linkrequest = Linkrequest.find(params[:id], :readonly=>true)
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

private

def destroy_this
		
      @myID = Linkrequest.find(params[:id])
      @instAlias = Linkrequest.find(params[:id]).organization_name
      Linkrequest.find(params[:id], :conditions=> ['organization_name = ?', @instAlias]).destroy
      redirect_to :controller=>'home', :action=>'show'
     
      rescue ActiveRecord::RecordNotFound
         error_msg = "Record not found in 'Changed My Mind' link request function"
     
      rescue ActiveRecord::ActiveRecordError
         error_msg = "Active Record Error in 'Changed My Mind' link request function"
     

end

def do_create

@linkrequest = Linkrequest.new(params[:linkrequest])
     
         if @linkrequest.save
           render  :action => 'show', :id => @linkrequest 
         else
           render :action => 'new'
         end

end


def display_select_picture

   @linkrequest =  Linkrequest.find(params[:id])
   path = File.join("public/client", @linkrequest.image_file_name)
   # write the file

##IO.read

   ## both example send the picture distorted, corrected by adding "b"
   #send_data(IO.read(path), 
   #            :filename => @linkrequest.image_file_name,
   #            :type => @linkrequest.image_content_type,
   #            :disposition => "inline")
   File.open(path, 'rb') do |f|
               send_data(f.read, 
               :filename => @linkrequest.image_file_name,
               :type => @linkrequest.image_content_type,
               :disposition => "inline")
    end
#Tip: if you want to stream large amounts of on-the-fly generated data to the browser, 
   #then use render :text => proc { ... } instead. See ActionController::Base#render for more information.

end


def do_sendmail
	
            @linkrequest = Linkrequest.find(params[:id])
            
            if (not @linkrequest.nil?)
			
                  begin
                  recipient = @linkrequest.email
		      subject = "Thanks for offering your link"
		      message = ""
      		body = {:first_name => @linkrequest.first_name, 
				  :last_name => @linkrequest.last_name,
				  :mi => @linkrequest.mi,
				  :mission => @linkrequest.mission,
                          :url => @linkrequest.organization_url, 
                          :guest_name => @linkrequest.organization_name} 
		      myemail = Notifier.contact(recipient, subject, message, body)
 		      myemail.deliver
			flash[:notice] = 'Message successfully sent to '  + recipient + '.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
                  rescue Exception => msg
		      	flash[:notice] = 'Error occurred in sending Link Request email to '  + recipient + '.  Specifically, error: ' + msg.message  
                        redirect_to :controller=>'home', :action=>'show', :id=>'errorpage'
                  end
		      
		else
                  flash[:notice] = 'Message not successfully sent to '  + recipient + '.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
		end
end

end
