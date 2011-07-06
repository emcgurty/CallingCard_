# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  # render new.rhtml
  def new
  end

  def create
    self.current_user = Users.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      #redirect_back_or_default('/')
        session[:user_id] = self.current_user.id
           if self.current_user.MI 
           session[:user_fullname] = self.current_user.first_name + " " + self.current_user.MI + " " + self.current_user.last_name
 	     else 
           session[:user_fullname] = self.current_user.first_name + " " + self.current_user.last_name
           end 
      session[:user_priv] = self.current_user.role

      flash[:notice] = "Logged in successfully"
      redirect_to :controller=> :home

    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    #redirect_back_or_default('/')
    redirect_to :controller=> :home 
 
  end
end