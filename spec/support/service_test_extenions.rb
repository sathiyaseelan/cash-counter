# Extensions for testing REST APIs as request tests
module ServiceTestExtensions

  # To build json for the factory and merge additional hash if any
  def build_json_for(factory:, root:, additional_data: {})
    {root => attributes_for(factory)}.merge(additional_data).to_json
  end

  def json_for(record,additional_data: {})
    record.attributes.merge(additional_data).to_json
  end

  # To parse the json and retrieve the value
  def response_value(key)
    JSON.parse(response.body)[key.to_s]
  end

  # to send post request with content type as json
  # it will accept additional params and headers
  def post_json(url:, params: {}, headers: {})
    post url, params: params, headers: headers(additional_headers: headers)
  end

  private

  # To construct the headers
  def headers(additional_headers:)
    headers = { "CONTENT_TYPE" => "application/json"}
    headers.merge!(additional_headers) if additional_headers
    return headers
  end

end
