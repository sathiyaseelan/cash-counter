class ResponseSerializer < ActiveModel::Serializer
  attributes :success
  self.root = false

  has_one :entity, root: :data
  has_one :token
end
