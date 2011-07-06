class CreateLinkrequest < ActiveRecord::Migration

 def self.up
    create_table :linkrequests, :id => false, :primary_key => :uuid,  :force => true do |t|
    t.string   :uuid, :limit => 36
    t.string   :organization_url,   :limit => 100
    t.boolean  :is_active,                         :default => false
    t.string   :comments
    t.string   :email,              :limit => 100
    t.string   :mission
    t.string   :organization_name,  :limit => 25
    t.string   :image_content_type
    t.string   :image_file_name
    t.string   :first_name,         :limit => 15
    t.string   :mi,                 :limit => 1
    t.string   :last_name,          :limit => 15
    t.string   :city,               :limit => 15
    t.integer  :country_id
    t.datetime :created_at
    t.datetime :placed_at
    t.integer  :state_id
    t.string   :zip_code,           :limit => 12
    t.boolean  :approved,           :default => false
    t.string   :remote_ip,          :limit => 45
    t.integer  :img_height
    t.integer  :img_width
    t.integer  :user_id,           :null => false
  end
 end

  def self.down
    drop_table :linkrequests
  end
end
