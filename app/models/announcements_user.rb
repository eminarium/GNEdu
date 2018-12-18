class AnnouncementsUser < ActiveRecord::Base
  self.primary_keys = :user_id, :announcement_id
  belongs_to :user
  belongs_to :announcement
end
