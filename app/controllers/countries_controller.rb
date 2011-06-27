class CountriesController < ApplicationController
 
   def getCountry
      @getC = Country.find(params[:id])
	@getC.country
  end

end
