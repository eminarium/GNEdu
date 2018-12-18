json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :announcementSubject, :announcementBody
  json.url announcement_url(announcement, format: :json)
end
