json.array!(@off_days) do |off_day|
  json.extract! off_day, :id, :off_day_title, :off_day_date, :is_annual, :notes
  json.url off_day_url(off_day, format: :json)
end
