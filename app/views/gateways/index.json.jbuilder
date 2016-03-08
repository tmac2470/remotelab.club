json.array!(@gateways) do |gateway|
  json.extract! gateway, :id, :title, :synched
  json.url gateway_url(gateway, format: :json)
end
