json.array!(@things) do |thing|
  json.extract! thing, :id
  json.url thing_url(thing, format: :json)
end
