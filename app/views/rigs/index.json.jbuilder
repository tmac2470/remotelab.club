json.array!(@rigs) do |rig|
  json.extract! rig, :id, :title, :rig_type, :user_id, :description, :pdf_file
  json.url rig_url(rig, format: :json)
end
