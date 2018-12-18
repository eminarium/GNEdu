class ModAction < ActiveRecord::Base
  belongs_to :mod_object

  has_many :mod_actions_roles
  has_many :roles, :through => :mod_actions_roles

end
