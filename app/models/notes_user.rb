class NotesUser < ActiveRecord::Base
  self.primary_keys = :note_id, :user_id
  belongs_to :note
  belongs_to :user
end
