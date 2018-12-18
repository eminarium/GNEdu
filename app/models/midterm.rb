class Midterm < ActiveRecord::Base
  self.primary_keys = :contract_id, :midtermOrderNo
  belongs_to :contract
end
