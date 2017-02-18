# Extensions for testing REST APIs as request tests
module ServiceTestExtensions

  # To build json for the factory and merge additional hash if any
  def build_json_for(factory_name,additional_hash={})
    attributes_for(factory_name).merge(additional_hash).to_json
  end
  def json_for(record,additional_hash={})
    record.attributes.merge(additional_hash).to_json
  end
  # To parse the json and retrieve the value
  def response_value(key)
    JSON.parse(response.body)[key.to_s]
  end

  # to send post request with content type as json
  # it will accept additional params and headers
  def post_json(url, options={})
    post url, params: options[:params], headers: headers(options)
  end

  private

  # To construct the headers
  def headers(options = {})
    headers = { "CONTENT_TYPE" => "application/json"}
    headers.merge!(options[:headers]) if options[:headers]
    return headers
  end

end
