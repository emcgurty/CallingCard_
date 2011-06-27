class UsersController < ApplicationController

 def create                              
      @users = Users.new(params[:users])
      
      if @users.save
         render :show
      else
         render :new
      end

 end

 def forgot_password
    render :text=>"Under construction..."
 end

 def forgot_username
    render :text=>"Under construction..."
 end


   def new
      @users = Users.new
   end

   def show
      if params[:function] == 'update_user_info'
		redirect_to :controller=>:users, :action=> :update_user_info
      end
    if params[:function] == 'updateuserinformation'
        if params[:users].blank?
           render :text=>'Error in updating user information'
        else
           @users = Users.find(session[:user_id])
	     if @users.update_attributes(params[:users])
	      session[:user_id] = nil
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

   def login

      #mysqlstr = "Select first_name, MI, last_name from Users where username = '" + params[:username].to_s + "' and password = '" + params[:password].to_s  + "'"
	#@users = Users.connection.execute(mysqlstr)
      @users = Users.find(:first, :conditions => ['username = ? and password = ?', params[:username], params[:password]])


      if @users.blank?
         render :text => 'Not successful in user:' 
      else
         session[:user_id] = @users.id
         session[:user_fullname] = @users.first_name + " " + @users.last_name
         session[:user_priv] = @users.role
         #render :text => 'Successful in new user:' + @users.first_name
         redirect_to :controller=>'home', :action=>'show'
      end

	end

    def update
        
      @users = Users.find(params[:users])
      if @users.update_attributes(params[:users])
         redirect_to :controller => 'Signatures', :action  => "show_refresh"
      else
         render :text => 'You made a mistake'
      end
 
   end



end
