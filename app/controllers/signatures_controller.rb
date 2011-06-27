class SignaturesController < ApplicationController

     # caches_page :show
     expire_page :action => :show_refresh, :id => @signatures
     ## cache_sweeper :signatures_sweeper
 	
def delete_display
	@signatures = Signatures.find(params[:id])
end

 	def delete
	Signatures.delete(params[:id])
      render :action=> :show_refresh
	end


      def show_refresh
	   expire_action :action => :show_refresh
         if (params[:id] == 'map')
           render :action=>'map'
         else
		do_show
         end
	 end
  
  
	def groupsof
	end	

   def new
      @signatures = Signatures.new
      myState = 'Virginia'
      @state = State.find(:first, :conditions => ['state = ?', myState])
      @signatures.state_id = @state[:id]
      myCountry = 'United States'
      @country = Country.find(:first, :conditions => ['country = ?', myCountry])
      @signatures.country_id  = @country[:id]
   end

   
 def create                              
    

      myAlias = params[:signatures].fetch(:alias)           
      ## alias will always be unique
      @signatures = Signatures.new(params[:signatures])
      
      if @signatures.save
		   
		   @signatures = Signatures.find(:first, :conditions => ['alias = ?', myAlias])
		   myID = @signatures[:id] 
               if (sendmail myID) 
               #render :text => "For some reason, this application was not able to send you email." 
               end
      else
            render :action => :new
	
      end

 end

  
 def map
 end


private

def do_show

    if params[:id].nil?   
       @signatures = Signatures.find(:all, :readonly=>true, :limit=>DISPLAY_ROWS, :order=>'signature_number ASC', :conditions=> ['signature_agreement =1'] )
      ## @signatures = Signatures.connection.execute("SELECT signature_number, first_name, last_name, alias, City, state_id, country_id, Postal_Code, created_at from signatures")
    else
      myID = params[:id]
      @signatures = Signatures.find(:all, :readonly=>true,  :conditions=> ['signature_agreement = 1 AND signature_number >= ?', myID], :limit=>DISPLAY_ROWS, :order=>'signature_number ASC')
    end
  
end 

def create_new_signature
    #  expire_page :action =>'new'


end



  def sendmail(cid)
	
            @signatures = Signatures.find(:first, :conditions => ['id = ?', cid])
            if (not @signatures.nil?)
               mycomment = @signatures[:comments] 
               myemail = @signatures[:email] 
               if ((!mycomment.blank? ) && (!myemail.blank?))

			begin
                  recipient = @signatures.email
		      subject = "Thanks for offering your comments"
		      message = ""
      		body = {:first_name => @signatures.first_name, 
				  :last_name => @signatures.last_name,
				  :mi => @signatures.mi,
				  :comments => @signatures.comments,
                          :alias => @signatures.alias} 
		      myemail = Notifier.signature_comments(recipient, subject, message, body)
 		      myemail.deliver
	      	flash[:notice] = 'Message successfully sent to '  + recipient + '.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
                  rescue Exception => msg
                  flash[:notice] = 'Message not successfully sent to '  + recipient + '. With error message: ' + msg.message
                  redirect_to :controller=>'home', :action=>'show', :id=>'errorpage'
                  end
             else
                 redirect_to :action=> 'show_refresh'
		 end
       end

  
end




end

