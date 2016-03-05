module ResponseHelpers
  def json_response
    JSON.parse(last_response.body)
  end

  def geo_json_features
    json_response['features']
  end
end
