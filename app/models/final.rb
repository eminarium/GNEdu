class Final < ActiveRecord::Base
  self.primary_keys = :contract_id
  belongs_to :contract
end
