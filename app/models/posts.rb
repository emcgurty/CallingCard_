class Posts < ActiveRecord::Base

      before_create :set_uuid

      def set_uuid
	    self.uuid = UUIDTools::UUID.timestamp_create().to_s
      end


end