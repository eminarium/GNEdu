class Role < ActiveRecord::Base
  #acts_as_authorization_role

  has_many :mod_actions_roles
  has_many :mod_actions, :through => :mod_actions_roles
  belongs_to :season
end
