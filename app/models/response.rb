class Response

  include ActiveModel::SerializerSupport

  attr_accessor :success, :entity, :token

  def initialize(entity, options= {})
    @entity = entity
    @success = options[:success]
    @token = options[:token]
  end

  def success?
    @success
  end
end
