class StatesController < ApplicationController
   def show
    @state = State.find(:all)
   end
  


end
