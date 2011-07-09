class PerspectivesController < ApplicationController
before_filter :login_required
## incomplete process before_filter :user_delete,  :only=>[:delete]
## cache_sweeper :perspectives_sweeper   For production only


   def new
   end

   def create
      do_create
   end

  def delete_confirm
	@perspectives = Perspectives.find(:first, :conditions => ['uuid = ?', params[:uuid]], :readonly => true)
  end

  def show
    do_show
   end

   def confirm
	@perspectives = Perspectives.find(:first, :conditions => ['uuid = ?', params[:uuid]], :readonly => true)
   end
  
   def destroy
      do_destroy
   end

   def accept
       sendmail params[:uuid]
   end

private

def do_create

       @perspectives = Perspectives.new(params[:perspectives])
       
       if @perspectives.save
            myID =  @perspectives.uuid
            render :action => 'confirm', :uuid => myID
       else
           render :action => 'new'
       end

end


 def sendmail(cid)
	
            
            @perspectives = Perspectives.find(:first, :readonly=> true, :conditions => ['uuid = ?', cid])
            if (not @perspectives.blank?)
			recipient = @perspectives.email
		      subject = "Thanks for offering your perspective comments"
		      message = ""
      		body = {:alias => @perspectives.alias, 
				  :comments => @perspectives.comments,
                          :created_at => @perspectives.created_at} 
		      myemail = Notifier.comments_received(recipient, subject, message, body)
 		      myemail.deliver
	      	flash[:notice] = 'Message successfully sent to '  + recipient + '.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
		      
		else
                  flash[:notice] = 'Message not successfully sent.'
                  redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
		end

		    

  
end



def do_show

	  @perspectives = Perspectives.find(:all, :readonly=> true, :conditions => "approved = 1" )
        rescue ActiveRecord::StatementInvalid 
		error_msg = "Invalid statement discovered in Listing Perspectives."
		redirect_to :controller=>'home', :action => 'error_page', :error_msg => @error_msg

end

 

def do_destroy

      begin
        Perspectives.find(:first, :conditions => ['uuid = ?', params[:uuid]]).destroy
        redirect_to :controller=>'home', :action=>'show'
      rescue Exception => msg
	  flash[:notice] = 'Error occurred in deleting link request.  Specifically, error: ' + msg.message 
        redirect_to :controller=>'home', :action=>'errorpage'
       end


      rescue ActiveRecord::RecordNotFound
         @error_msg = "Record not found in 'Changed My Mind' perspectives function"
         redirect_to :controller=>'home', :action=>'error_page', :error_msg => @error_msg
      rescue ActiveRecord::ActiveRecordError
         @error_msg = "Active Record Error in 'Changed My Mind' perspectives function"
         redirect_to :controller=>'home', :action=>'error_page', :error_msg => @error_msg

end

 ## def user_delete

 ## @random_word = SecureRandom.hex(12)
 ## @random_word = @random_word.to_s
 ## newUser = {:machine_ip => request.remote_ip, :random_word => @random_word.ljust(12), 
 ##             :created_at => Time.now, :activity => 'Delete Perspective'}
  
 ## @usersession = Usersessions.new
 ## @usersession = Usersessions.new(newUser)
 ## @usersession.save
    
 ## end


end

