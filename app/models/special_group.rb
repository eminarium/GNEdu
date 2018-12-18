class SpecialGroup < ActiveRecord::Base
  belongs_to :season
  has_many :contracts

  validates_presence_of :season_id, :message => "'Tapgyry' hökman saýlanmaly ..."
  validates_presence_of :specialGroupTitle, :message => "'Ady' hökman ýazylmaly ..."

end
