json.array!(@things) do |thing|
  json.extract! thing, :id, :thing_logs, :thing_name
  json.url thing_url(thing, format: :json)
end
