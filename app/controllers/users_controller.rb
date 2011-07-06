class UsersController < ApplicationController

   def show
      if params[:function] == 'update_user_info'
		redirect_to :controller=>:users, :action=> :update_user_info
      end
    if params[:function] == 'updateuserinformation'
        if params[:users].blank?
           render :text=>'Error in updating user information'
        else
           @users = Users.find(session[:id])
	     if @users.update_attributes(params[:users])
	      #session[:user_id] = nil
            redirect_to :controller => 'Users', :action  => "show"
           else
		render :text=>'Error in updating user informaton'
          end 
       end
    end 
   end

   def update_user_info
     @users = Users.find(:first, :conditions => ['id = ?', session[:user_id]])
   end


    def update
        
      if params[:function] == 'updateuserinformation'
        if params[:users].blank?
           render :text=>'Error in updating user information'
        else
           @users = Users.find(session[:user_id])
	     # @users.create_reset_code
if @users.update_attributes(params[:users])
	      session[:user_id] = nil
            redirect_to :controller => 'Users', :action  => "show"
           else
		render :text=>'Error in updating user informaton'
          end 
       end
    
 else	
@users = Users.find(params[:users])
      if @users.update_attributes(params[:users])
         redirect_to :controller => 'Signatures', :action  => "show_refresh"
      else
         render :text => 'You made a mistake'
      end
end


   end

   def new
      @users = Users.new
   end

   def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @users = Users.new(params[:users])
    @users.save
    if @users.errors.empty?
            redirect_back_or_default('/')
            flash[:notice] = "Thanks for signing up! Please check your email to activate your account."
           # redirect_to :controller => :signatures, :action => :show_refresh
           #redirect_to :controller=>'home', :action=>'show'
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : Users.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end
  
  def forgot
    if request.post?
      @users = Users.find(:first, :conditions => ['email = ?', params[:users][:email]])
      respond_to do |format|
        if !(@users.blank?)
          @users.create_reset_code
          #myemail =  myemail = UserMailer.reset_notification(@users)
          #myemail.deliver

          flash[:notice] = "Reset code sent to #{@users.email}"
          format.html { redirect_to login_path }
          #format.xml { render :xml => @users.email, :status => :created }
        else
          flash[:error] = "#{params[:users][:email]} does not exist in system"
          format.html { redirect_to login_path }
          #format.xml { render :xml => @users.email, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def reset
    @users = Users.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    if request.post?
      if @users.update_attributes(:password => params[:users][:password], :password_confirmation => params[:users][:password_confirmation])
        self.current_user = @users
        @users.delete_reset_code
        flash[:notice] = "Password reset successfully for #{@users.email}"
        redirect_to root_url
      else
        render :action => :reset
      end
    end
  end

end


