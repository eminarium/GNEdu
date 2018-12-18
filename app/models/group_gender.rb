class GroupGender < ActiveRecord::Base

  def groupGender_complete_name
    "#{self.groupGenderFullName} - "  " #{self.groupGenderShortName}"
  end

end
