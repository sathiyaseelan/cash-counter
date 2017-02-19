class Response

  include ActiveModel::SerializerSupport

  attr_accessor :success, :entity, :token

  def initialize(entity, success: true, token: nil)
    @entity = entity
    @success = success
    @token = token
  end

  def success?
    @success
  end
end
