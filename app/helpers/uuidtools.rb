require 'rubygems'
require 'uuidtools'

module UUIDHelper
def before_create
self.uuid = UUIDTools::UUID.timestamp_create().to_s
end
end


#create_table :posts, :id => false do |t|
#  t.string :uuid, :limit => 36, :primary => true
#end

