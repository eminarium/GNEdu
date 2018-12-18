class BookContest < ActiveRecord::Base
  belongs_to :season

  has_many :book_contest_participants
end
