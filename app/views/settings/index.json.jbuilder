json.array!(@settings) do |setting|
  json.extract! setting, :id, :settingName, :settingValue, :notes
  json.url setting_url(setting, format: :json)
end
