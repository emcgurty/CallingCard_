class UsersController < ApplicationController

   def show
      @users = Users.find(:first, :conditions=>['user_id = ?', session[:user_id]])
   end

    def update
      begin
       @users = Users.find(:first, :conditions=>['user_id = ?', session[:user_id]])
       @users.update_attributes(params[:users])
	   rescue Exception => msg
            render :show
        else
		render :text=>'Not Error in updating user informaton'
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
    # @users = Users.new(params[:users])
    @users = Users.new(:login =>params[:users][:login], 
                       :first_name=>params[:users][:first_name], 
                       :last_name=>params[:users][:last_name],
                       :password=>params[:users][:password], 
			     :password_confirmation=>params[:users][:password_confirmation], 
                       :email=>params[:users][:email] )
    if  @users.save  && @users.errors.empty?
            redirect_back_or_default('/')
            flash[:notice] = "Thanks for signing up! Please check your email to activate your account."
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


