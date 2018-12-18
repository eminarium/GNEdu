class Author < ActiveRecord::Base

  def full_name
    "#{self.authorFName} " " #{self.authorLName}"
  end
end
