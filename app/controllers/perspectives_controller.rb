class PerspectivesController < ApplicationController
before_filter :login_required
before_filter :user_delete,  :only=>[:delete]
##cache_sweeper :perspectives_sweeper


   def new
   end

   def create
      do_create
   end

  def delete_confirm
	@perspectives = Perspectives.find(params[:id], :readonly => true)
  end

  def show
    do_show
   end

   def options
	end

   def confirm
	@perspectives = Perspective.find(params[:id], :readonly => true)
   end
  
   def destroy
      do_destroy
   end

   def accept
       do_accept
   end

private

def do_accept

        @myID = Perspectives.find(params[:id]) 
        sendmail @myID.id

end

def do_create

       @perspectives = Perspectives.new(params[:perspectives])
       
      if @perspectives.save
            myID =  @perspectives.id
            render :action => 'confirm', :id => myID
      else
           render :action => 'new'
      end

end


 def sendmail(cid)
	
            
            @perspectives = Perspectives.find(:first, :conditions => ['id = ?', cid])
            if (not @perspectives.nil?)
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
                  flash[:notice] = 'Message not successfully sent to '  + recipient + '.'
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

	@myID = Perspectives.find(params[:id])
      @instAlias = Perspectives.find(params[:id]).alias
      Perspectives.find(params[:id], :conditions=> ['alias = ?', @instAlias]).destroy
      redirect_to :controller=>'home', :action=>'show'

      rescue ActiveRecord::RecordNotFound
         @error_msg = "Record not found in 'Changed My Mind' perspectives function"
         redirect_to :controller=>'home', :action=>'error_page', :error_msg => @error_msg
      rescue ActiveRecord::ActiveRecordError
         @error_msg = "Active Record Error in 'Changed My Mind' perspectives function"
         redirect_to :controller=>'home', :action=>'error_page', :error_msg => @error_msg

end

  def user_delete

  @random_word = SecureRandom.hex(12)
  @random_word = @random_word.to_s
  newUser = {:machine_ip => request.remote_ip, :random_word => @random_word.ljust(12), 
              :created_at => Time.now, :activity => 'Delete Perspective'}
  
  @usersession = Usersessions.new
  @usersession = Usersessions.new(newUser)
  @usersession.save
    
  end


end
