json.array!(@laboratories) do |laboratory|
  json.extract! laboratory, :id, :title, :laboratory_type, :user_id, :description, :pdf_file
  json.url laboratory_url(laboratory, format: :json)
end
