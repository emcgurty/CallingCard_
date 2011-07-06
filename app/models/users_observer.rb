class UsersObserver < ActiveRecord::Observer
  

 observe :users
 def after_create(users)
    
    Notifier.deliver_signup_notification(users)
  end

  def after_save(users)
  
    Notifier.deliver_activation(users) if users.recently_activated?
    Notifier.deliver_reset_notification(users) if users.recently_reset?
  
  end
end
