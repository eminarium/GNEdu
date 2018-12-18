json.array!(@mod_objects) do |mod_object|
  json.extract! mod_object, :id, :modObjectName, :description
  json.url mod_object_url(mod_object, format: :json)
end
