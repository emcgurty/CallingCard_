class LinkrequestsObserver < ActiveRecord::Observer
  
  observe :linkrequests

  def before_create(linkrequests)
    linkrequests.uuid = UUIDTools::UUID.timestamp_create().to_s
    
  end

  #def after_create(linkrequests)
#	
 #   recipient = linkrequests.email
  #  subject = 'Thanks for offering your link'
   # message = ''
    #body = {:first_name => linkrequests.first_name, 
	#			  :last_name => linkrequests.last_name,
	#			  :mi => linkrequests.mi,
	#			  :mission => linkrequests.mission,
       #                   :url => linkrequests.organization_url, 
        #                  :orgainzation_name => linkrequests.organization_name} 
    # Notifier.deliver_contact(recipient, subject, message, body)
  
  #end

 
end
