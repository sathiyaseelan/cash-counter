class ResponseSerializer < ActiveModel::Serializer
  attributes :success
  self.root = false

  has_one :entity, root: :data
  has_one :token

  def filter(keys)
    keys.delete :token if object.token.nil?
    keys
  end
end
