class ContestantBook < ActiveRecord::Base
  self.primary_keys = :book_id, :book_contest_id

  belongs_to :book
  belongs_to :book_contest
end
