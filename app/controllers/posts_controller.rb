class PostsController < ApplicationController

   def new
   end


def create                              
      @posts= Posts.new(params[:posts])
      
      if @posts.save
	   render :text => "You got UUID to work." 
      else
         render :text => "UUID didn't work"
      end
end

end


