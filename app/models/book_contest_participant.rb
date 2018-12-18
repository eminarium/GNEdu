class BookContestParticipant < ActiveRecord::Base
  belongs_to :contract
  belongs_to :book_contest
  belongs_to :book_language

  has_many :contracts
end
