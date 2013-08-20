json.array!(@checks) do |check|
  json.extract! check, 
  json.url check_url(check, format: :json)
end
