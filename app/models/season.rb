class Season < ActiveRecord::Base

  #after_commit :flush_open_groups_cache, :flush_season_active_contracts_cache, :flush_season_returned_contracts_cache, :flush_season_timetables_cache

  has_many :season_tests
  has_many :contracts
  has_many :groups
  has_many :exams
  has_many :announcements
  has_many :roles
  has_many :book_contests

  validates_presence_of :seasonNo, :message => "'Belgisini' hökman girizmeli ..."
  validates_presence_of :seasonTitle, :message => "'Möwsümini we Ýylyny' hökman girizmeli ..."
  validates_presence_of :seasonFromDate, :message => "'Başlangyç Senesini' hökman saýlamaly ..."
  validates_presence_of :seasonToDate, :message => "'Tamamlanýan Senesini' hökman saýlamaly ..."
  validates_presence_of :return_deadline, :message => "'Gaýtarma Soňky Senesini' hökman saýlamaly ..."

  def self.active_season
    Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue)  # Get current season from Settings object
  end

  ######################################################################################

  def cached_current_season_open_groups
    Rails.cache.fetch("open_groups", expires_in: 240.hours){Group.where(:season_id => self.id, :isClosed => false)}
  end

  def self.flush_open_groups_cache
    Rails.cache.delete("open_groups")
  end

  ######################################################################################

  def cached_current_season_active_contracts
    Rails.cache.fetch("active_contracts", expires_in: 240.hours){Contract.where(:isMoneyReturned => false, :season_id => self.id)}
  end

  def self.flush_season_active_contracts_cache
    Rails.cache.delete("active_contracts")
  end

  ######################################################################################

  def cached_current_season_returned_contracts
    Rails.cache.fetch("returned_contracts", expires_in: 240.hours){Contract.where(:isMoneyReturned => true, :season_id => self.id)}
  end

  def self.flush_season_returned_contracts_cache
    Rails.cache.delete("returned_contracts")
  end

  ######################################################################################

  def cached_current_season_timetables
    Rails.cache.fetch("active_timetables", expires_in: 240.hours){Timetable.where(:group_id => self.cached_current_season_open_groups.select(:id))}
  end

  def self.flush_season_timetables_cache
    Rails.cache.delete("active_timetables")
  end

end
