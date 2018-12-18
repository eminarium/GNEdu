class Position < ActiveRecord::Base
  self.primary_keys = :user_id, :position_number
  belongs_to :user
end
