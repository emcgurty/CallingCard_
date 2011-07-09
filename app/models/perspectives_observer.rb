class PerspectivesObserver < ActiveRecord::Observer
  
  observe :perspectives

  def before_create(perspectives)
    
     perspectives.uuid = UUIDTools::UUID.timestamp_create().to_s
     
  end

  
end
