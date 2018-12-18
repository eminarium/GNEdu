class AuthorsBook < ActiveRecord::Base
  self.primary_keys = :book_id, :author_id
  belongs_to :book
  belongs_to :author
end
