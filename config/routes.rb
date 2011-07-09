Banumva::Application.routes.draw do
  
resources :author do
end

#resources :sessions do

#  member do
#    get :destroy
#  end

#end

resources :users do
  
  member do
    post :login
  end
 
  member do
    post :update
  end

  member do
    get :update_user_info
  end

# member do
#    post :activate
#  end

member do
    post :show
  end
end

resources :signatures do
  
  member do
    get  :show_refresh
  end
 
  member do
    get  :delete_display
  end

 
end

resources :linkrequests do
  
 
  member do
    delete  :destroy
  end

member do
    post  :new
  end



end

resources :perspectives do
  
  member do
    get :delete_confirm
  end
 
  member do
    post :create
  end

  member do
    get :update_user_info
  end

end


 ActionController::Routing::Routes.draw do |map|   
      map.resources :home
     # map.resources :users
     # map.resources :users, :member => { :login => :post }
     # map.resources :users, :member => { :update_user_info => :get }
     # map.resources :users, :member => { :update=> :post }
     # map.resources :signatures
     # map.resources :signatures, :member => { :show_refresh => :get }
     # map.resources :signatures, :member => { :delete_display => :get }
     # map.resources :perspectives
     # map.resources :perspectives, :member => { :delete_confirm => :get }
     # map.resources :perspectives, :member => { :create=> :post }
      map.resources :linkrequests
      map.resources :perspectives
	map.sendmail  '/sendmail', :controller => 'linkrequests', :action => 'sendmail'
	map.accept  '/accept', :controller => 'perspectives', :action => 'accept'
      map.resources :states
      map.resources :countries
	map.resources :author
      map.resource :sessions
    	map.activate  '/activate/:activation_code', :controller => 'users', :action => 'activate'
	map.signup    '/signup', :controller => 'users', :action => 'new'
	map.login     '/login', :controller => 'sessions', :action => 'new'
	map.logout    '/logout', :controller => 'sessions', :action => 'destroy'
	map.forgot    '/forgot', :controller => 'users', :action => 'forgot'
	map.reset     'reset/:reset_code', :controller => 'users', :action => 'reset'
 #    map.root :controller => 'home', :action => 'index'
      map.root :controller => 'sessions', :action => 'new'
      map.connect ':controller/:action/:id.:format'
   end
 match ':controller(/:action(/:id(.:format)))'
end
