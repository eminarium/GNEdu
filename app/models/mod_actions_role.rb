class ModActionsRole < ActiveRecord::Base
  self.primary_keys = :role_id, :mod_action_id
  belongs_to :role
  belongs_to :mod_action
end
